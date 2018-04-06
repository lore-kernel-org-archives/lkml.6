Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+3dpbYoBf80OMRA8uSMBfhLlU7sIAL/hNdGj2tgQbz/KE3H3Yc3FJukisWtI3qfzg6im1L
ARC-Seal: i=1; a=rsa-sha256; t=1523021372; cv=none;
        d=google.com; s=arc-20160816;
        b=Xetipr4vvuBz3hB/cg/BPm9/lsZsLdDFCoZhWXn/3omWkKFGpY6Ly/mS50nCe+IlEf
         UIJEtkjmjkl5sYSUyGxyJv9Lk/lQGptGLSmoLOyTqbPmtJ1bEFIKdZx4OweXVx0prx6Y
         zxwdo2AF1UPtQb7oPLTiKdxL8asstk9DhVTsIa6TxY0Euy6T3DL2fW0eVwUa5Bxb60Ot
         vOEN/PeN8S3DNUhbENQN2Zjh3879bfclksPKhx6dujvNB/TsetyBDSN+2Nnp7NWRCn3N
         2Yv42NxTSNKGI+FXJ2zIBSX95qpn7ubbV3Lt+ZfCxK6c9k16zaO689steYJmZgJQuwAe
         lpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QDDvei3aYKRitfSNU8etO6eLaiEFLA+HkDSaZYDt8Ug=;
        b=az2vBuMbKQUlpLzsf19SLilN5n8xdLCUob23yQ29+qd3MyqwWMDrSVPshHBnQi3gQb
         yvFOKIqIHZVVnpQH2dZRA/s+Zf81ej9LfiUSbUidxLQHFq9fsyrFw0bGQ1h3HIuwmJyx
         MdFS7oYG6Y6tyLRpiS9M112RO4KTQ70/SbzATmv724qwlDD8gGtRVpQ3+JN5f1rh5+Tk
         9Ungpu9XgKxF2u9NGv9IUQagSO8DDhZyHcD9m0cQjixj/SQM6Ubx94JVz3xGPGhnX7r3
         FRkiOoV5l5dlUerJh59yn6VC/mXcLrm/F0W4s1VVy9fnQrkJ7T5WBs04qqITcA2T6FDR
         XDZA==
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
Subject: [PATCH 4.4 05/72] partitions/msdos: Unable to mount UFS 44bsd partitions
Date: Fri,  6 Apr 2018 15:23:06 +0200
Message-Id: <20180406084305.567693900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003471959644591?=
X-GMAIL-MSGID: =?utf-8?q?1597003659352002684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
