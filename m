Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49rt31dwvCoBEw/OJn0SiX4eMeCPIamYlmqxDDAW/XEgK1T+BdMZD1Dl8TwiA32xvJffivr
ARC-Seal: i=1; a=rsa-sha256; t=1523021194; cv=none;
        d=google.com; s=arc-20160816;
        b=Hi66EPfkHa1yX9QRaQVrmGEHLvRoJAHYVPSMAzk/wabe7uNynU4f6sLHyVki0B2td8
         RutxVXADuZjBEgW0gIB80CHJLIfTvM/0YODwnhFOjxgdxZw4OW0b26lvsQ/B6V+II3wo
         OUSoYZ7jphNJBEr3XhegzRmOzFVPJEXPzOZQYyrVaT5ZjROjD1CRX/TOlRB+eFCX5VCb
         Fx2E6ows0CwocaOdg16GHfK0D0BLAdU0BRSQhpxhh1PdcuJbaIps1CiNoebr3wDCiOEz
         NUbZlJWxLwwLAXiu46Tka3I7nXJwrDoTiTNESmURPnOQTgcsoUb/5TBwGbwg7P+I4/ku
         E6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D6Zo0T5xxe1lDb7sXw1MsVfY7YGxzbaEKx+DEY7HtPo=;
        b=D2gNnonBN1BGWtTSNqDqZJxQ0a6kKcbiNqZwpt5tc02AkFIIoLrVZVaaw0M20wCl4I
         l5HgcRzG5DEBr8E1QlFhE2TGg1Mn3QRgf+5Iu2jm5lVdvGI7IbMQfxWRTPpNFgGOxmOR
         q8zUrlxuv2aQPVswxjGGlYh+pRpk0GlTJ7cARBaE3NEmejgkR7ofg9ouUg2N40bjRW3j
         LT0cITf7bosvRcNCp11XFcfEe3gKad1WrWzTADNswTpwbUdwS+XcL85Fuo21RZqDoltD
         KtrKoVKdvhWLtJ65IgpGs5Kv3q5h+PjdOuumvEGiDSD0evX4IIxeSbVmNUAp5eZAclKQ
         M8lg==
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
Subject: [PATCH 3.18 41/93] partitions/msdos: Unable to mount UFS 44bsd partitions
Date: Fri,  6 Apr 2018 15:23:10 +0200
Message-Id: <20180406084226.735573501@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003471959644591?=
X-GMAIL-MSGID: =?utf-8?q?1597003471959644591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
