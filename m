Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227GQb/Emcjop7jE3Xp2lmbzNcCy6/4WvB9VhPnyNaU5XMRM6f3tx8RKt659ioLN8Sr1m9wO
ARC-Seal: i=1; a=rsa-sha256; t=1519218231; cv=none;
        d=google.com; s=arc-20160816;
        b=nUevz35SPpXpKyIhuGR/cvVbH2zkCv3Qm+DLqk3t6vygllEVSoocr01CtX3Dw2gSw9
         vLjQZhND/Nm411uGbSAQVXBTJXKHD2Ocdf1iyMz17mKMpI5CJMH+W6upo6upROHSnU5N
         aHZsAsqV9iqWUZIFdZuUEuhS4s+nFeSBt8y69HtS7/fkSsTVLFb1TZcoHV0UDPkO0ZGz
         yz1TLaSN5GzKNbl/VtWzGdrzqUq6KEHXXoYKigEui0VMDhuXeod9ZMJM5SlPoQUYggED
         JRCSgQz5Uu979j/KM5ie+wEfvqa0j9QxMUCXWoPeCXpS36DQOz34D7NCcyXWhomSb6w/
         Ptxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hAfbMRGnI2hWA0FPNl+VuCo3f02zWBn9qZH4Ve7W2EA=;
        b=kHf8L+JyuZfufxpEu+gpmQi6gC5hIjAdnwv8Rc/jkdQS/HYwn4gQIecaRfka2D7B19
         p1iTWvyOjGiKXviyyJeTC6XBMXobTaLPRRJRHUsOAfbRuuBrz118VG9cSt1t5BjVr9DX
         X+rJGD5TDEn7FTz+cRXvoLvEOL53BLG2+zhnMl7Dk0jI0wyBCogdIAogXDUQPmd4BIy1
         BLNwqlUFAc5OGVcpsPKHYYD32bGmr8noFUR57AUbLYSI2IuBFC9x9l3y9csz1jzwY/ku
         LBTQEDs4/x/B+gDBBWkCYyr/Wo2KECLf/2nhCAlyHVsVrj99XmOvJPjCHe+Sg2fVOJE/
         gfCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neilb@suse.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 133/167] dm: correctly handle chained bios in dec_pending()
Date: Wed, 21 Feb 2018 13:49:04 +0100
Message-Id: <20180221124531.917967879@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014686624050782?=
X-GMAIL-MSGID: =?utf-8?q?1593015775616580578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

commit 8dd601fa8317243be887458c49f6c29c2f3d719f upstream.

dec_pending() is given an error status (possibly 0) to be recorded
against a bio.  It can be called several times on the one 'struct
dm_io', and it is careful to only assign a non-zero error to
io->status.  However when it then assigned io->status to bio->bi_status,
it is not careful and could overwrite a genuine error status with 0.

This can happen when chained bios are in use.  If a bio is chained
beneath the bio that this dm_io is handling, the child bio might
complete and set bio->bi_status before the dm_io completes.

This has been possible since chained bios were introduced in 3.14, and
has become a lot easier to trigger with commit 18a25da84354 ("dm: ensure
bio submission follows a depth-first tree walk") as that commit caused
dm to start using chained bios itself.

A particular failure mode is that if a bio spans an 'error' target and a
working target, the 'error' fragment will complete instantly and set the
->bi_status, and the other fragment will normally complete a little
later, and will clear ->bi_status.

The fix is simply to only assign io_error to bio->bi_status when
io_error is not zero.

Reported-and-tested-by: Milan Broz <gmazyland@gmail.com>
Cc: stable@vger.kernel.org (v3.14+)
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -815,7 +815,8 @@ static void dec_pending(struct dm_io *io
 			queue_io(md, bio);
 		} else {
 			/* done with normal IO or empty flush */
-			bio->bi_status = io_error;
+			if (io_error)
+				bio->bi_status = io_error;
 			bio_endio(bio);
 		}
 	}
