Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+wmoZ8zuhRYtPXGZU/krrWW+Zon8zbWHio+uoOigCiX40NTFRBrdnDKrty3r6TuPB/Wxzb
ARC-Seal: i=1; a=rsa-sha256; t=1523021567; cv=none;
        d=google.com; s=arc-20160816;
        b=006uOsSV2dCwA2lrba2cj1JboE1Mx2wGvzW49XYdPdPlGwwPhgO6JSB6BZVtyfHXM4
         WBEedlLI40y/Smx2H/B2LdPVL4aLEuaGc4j+rNxU92JKdSrcje3FzbmKwS4SZ03iWSoj
         jSv5c7IuWvYprz0TDzDLh1eq4+OemsqvObpjgtoaq9QcimtM3qW+kELeEFapbdhFOx4G
         NbrbJOigvz4Il7iBpxkNzlyL0zCFMsb7dIuPxjDyQAHi+P1aR25/LXaTQKUX3NMOWr/q
         f4rBhRmzwBlDV9vFOt2+6HUolX5pIHsNm3hxbyIDTLC3xkbfmgdT+2nzEXMnItjFL8js
         Be6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mzmwjcVNX0IDV+98UrwpJ3ndoWyIYfF5nrwm24qvtqw=;
        b=n8yT1PbR4VK4PY6Yra0Rv78Z167HifREnD7dkwGkFA05e3SLDN5H6JVqwO/9+cNqK0
         riMSWQcRwYx1ju3qDmmFn475tekg6kcLUmK3nEWTPMu+33+lhUqXjnMHr5fOOEkch75W
         An9ABf2zJRZyexGsjjj2S1uIRyxThqfzt2lz+7A+0gitdedBpAJWlfgdJk9+RhHeQyrZ
         /EjXUZ2BVob4nty/pw0eQAn/fBZWrtsWmm2vEC//jepPo+WvGlPrVCNYJBgWaFwsvMk+
         RzXLnl65HbpbAzeDsx0Z+KfcHWZqGvBldShf+/ASgVYFi8thzL1XEuH4b+27cXw2cNA+
         afjA==
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
Subject: [PATCH 4.9 011/102] partitions/msdos: Unable to mount UFS 44bsd partitions
Date: Fri,  6 Apr 2018 15:22:52 +0200
Message-Id: <20180406084333.178691709@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003471959644591?=
X-GMAIL-MSGID: =?utf-8?q?1597003863240413612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -300,7 +300,9 @@ static void parse_bsd(struct parsed_part
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
