Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELskbAHF42u4YhkQJJ51ln+1hUXFaqA6YPVZRdDwTmn1HmEQxfj7oOmr11t1p9jqz3x7zDPZ
ARC-Seal: i=1; a=rsa-sha256; t=1520955020; cv=none;
        d=google.com; s=arc-20160816;
        b=AK+FoAIFGrGntyCOLr6QStAd55FwQ5lefPv/tvf/UrUmBPRWvJ16MnnMw1xXbP4gN3
         6CPFE2AxP7bQcDtwGDJjU8Uo5xAh4606oaUuuZgKUaHMNI9Fdm7IAMd4iFD1zC0cpPiT
         nuVDDKtRGOVYhsNvcz20DQK/WuTuXwGzTLVQqld1pg/rAXxjNk5CTIZMoL2vDOAsrbz4
         AQ8EWH3DllxxANyHdpAFgfQfaHjdzKWKkoS8ATNU0qXZ3tI1wFreid35jCmkzWR54GX3
         sRjfdyGYTGRdyi7wAn3x9p3DhwnuN03UX6PJ1zbpDDn7TBEEnVcQxmiM/BzJF+40Rd0s
         U65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VRzZ0RX+KfqMvoBfNyIq4YMAcx7bekYku+RCjIJS7r0=;
        b=y4q9dM/+yqZ2OL50DzMPZoGgBQD5kg1spLh6A1jR0D/Y8T/ZsntlcypYOiqut6eQXY
         GZheCGZojVy1Me1ehpNDTYkWyTfXoQ9rgsrd+XsCZITArBN+VbYbN6hssDHE71rk78G9
         XARO6Z/uzRiwpZqMyyciqsJE2gmPFj3w4tCo6x91e4+pdoBM0N5yz0UdIo+S32Q4C979
         nTVILNNuGajdchhQY4NX1k3DSqr8eJvFa2HCm+64nBrmq+OPe3XzR/Yk18QcEoQXHt6J
         MtlJNHMFK4AcDT+t3CLbXIcVs7mt/nGH0eQAtVEtZVQHr5a1EPPjPzl5JOLdwepStNE6
         AudA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Lyle <mlyle@lyle.org>,
	Tang Junhui <tang.junhui@zte.com.cn>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 061/146] bcache: dont attach backing with duplicate UUID
Date: Tue, 13 Mar 2018 16:23:48 +0100
Message-Id: <20180313152325.385945864@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836931424200756?=
X-GMAIL-MSGID: =?utf-8?q?1594836931424200756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Lyle <mlyle@lyle.org>

commit 86755b7a96faed57f910f9e6b8061e019ac1ec08 upstream.

This can happen e.g. during disk cloning.

This is an incomplete fix: it does not catch duplicate UUIDs earlier
when things are still unattached.  It does not unregister the device.
Further changes to cope better with this are planned but conflict with
Coly's ongoing improvements to handling device errors.  In the meantime,
one can manually stop the device after this has happened.

Attempts to attach a duplicate device result in:

[  136.372404] loop: module loaded
[  136.424461] bcache: register_bdev() registered backing device loop0
[  136.424464] bcache: bch_cached_dev_attach() Tried to attach loop0 but duplicate UUID already attached

My test procedure is:

  dd if=/dev/sdb1 of=imgfile bs=1024 count=262144
  losetup -f imgfile

Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Tang Junhui <tang.junhui@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/super.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -951,6 +951,7 @@ int bch_cached_dev_attach(struct cached_
 	uint32_t rtime = cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
 	char buf[BDEVNAME_SIZE];
+	struct cached_dev *exist_dc, *t;
 
 	bdevname(dc->bdev, buf);
 
@@ -974,6 +975,16 @@ int bch_cached_dev_attach(struct cached_
 		return -EINVAL;
 	}
 
+	/* Check whether already attached */
+	list_for_each_entry_safe(exist_dc, t, &c->cached_devs, list) {
+		if (!memcmp(dc->sb.uuid, exist_dc->sb.uuid, 16)) {
+			pr_err("Tried to attach %s but duplicate UUID already attached",
+				buf);
+
+			return -EINVAL;
+		}
+	}
+
 	u = uuid_find(c, dc->sb.uuid);
 
 	if (u &&
