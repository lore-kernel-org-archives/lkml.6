Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/BgWaPY7VCNsUpMhYCUbWKoWhCUggHPKfinc4aD1NMBcAniQ4V0DNriurazOWs7rS0H5XM
ARC-Seal: i=1; a=rsa-sha256; t=1523022167; cv=none;
        d=google.com; s=arc-20160816;
        b=GxMEH/8sigkF0eZKbfn6jUFaposIZI5FsmxVmLxnVl+5/+rmyEgSiKazl77fIVNUo3
         IK8qdJz+KqZDaAhkcSlvMRtkvGkt56cvNvtJgi+Wv+w0gCWcFeFZ9hD5No2JBIe23zBo
         ZmO/+Z35Raxhl8oQcvjnFPa6sh1KJY5veSJ0FkxKMq883wAtpF+F3S5eCfNcAmqCBtzC
         26F/TrLMQMw/Sqgw+soHjdRLBLBNe4eXsOrlXyGxsoFOpInZh5GRVIo38eM01NtGXmn9
         SGzEkFAVi70CofvbiBZCa8RtfuTI01urWKR5igBM1xfxiP+AepYpd1rqYOtfhB4WK9bu
         ZLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i81y95SphwIA0xta0fWnf+JQjM62Zeir/WJJ6JkMTYw=;
        b=ini/a4f93WSu6t0541waSBeMz/LkHgShb10U+G4sbstzp1tQwmwsH0sJXT4+YvfahM
         PuPsoZ+njGMMvXsOfWVTUfKg7XSOJ1Ygd+eyX0Tc0XV5igGYMG2rHlDJWPT8DFSKBG71
         dSv/tgWsTEwr47+1Ns/sMuIaBEW4+0S+6kPDs0yQwVc7DId83oUqJddsvq20jbXbzsnW
         VQ6KeU0quWgeF8bLZAPxIsP3vAOJuniR2MIaViMaHiSAIaJi1prkJkEJXdMUwjVpv1oL
         TXyTBoeL3Mf07SEJynETvxoHZCyjajzjWjxdN0zDuDvJiTsyfzS8mS7pzIJ+dYVsupv6
         JNQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Narron <comet.berkeley@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 19/72] partitions/msdos: Unable to mount UFS 44bsd partitions
Date: Fri,  6 Apr 2018 15:23:54 +0200
Message-Id: <20180406084351.037692464@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003471959644591?=
X-GMAIL-MSGID: =?utf-8?q?1597004492409715360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Narron <comet.berkeley@gmail.com>

commit 5f15684bd5e5ef39d4337988864fec8012471dda upstream.

UFS partitions from newer versions of FreeBSD 10 and 11 use relative
addressing for their subpartitions. But older versions of FreeBSD still
use absolute addressing just like OpenBSD and NetBSD.

Instead of simply testing for a FreeBSD partition, the code needs to
also test if the starting offset of the C subpartition is zero.

https://bugzilla.kernel.org/show_bug.cgi?id=197733

Signed-off-by: Richard Narron <comet.berkeley@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/partitions/msdos.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/block/partitions/msdos.c
+++ b/block/partitions/msdos.c
@@ -301,7 +301,9 @@ static void parse_bsd(struct parsed_part
 			continue;
 		bsd_start = le32_to_cpu(p->p_offset);
 		bsd_size = le32_to_cpu(p->p_size);
-		if (memcmp(flavour, "bsd\0", 4) == 0)
+		/* FreeBSD has relative offset if C partition offset is zero */
+		if (memcmp(flavour, "bsd\0", 4) == 0 &&
+		    le32_to_cpu(l->d_partitions[2].p_offset) == 0)
 			bsd_start += offset;
 		if (offset == bsd_start && size == bsd_size)
 			/* full parent partition, we have it already */
