Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/kDjO8P3FX2Ijljp8kjeg8QO0WVxSWqdreKXfpEt7OsfNphy3PJ2YRGLY3xPsto05gX/6
ARC-Seal: i=1; a=rsa-sha256; t=1523022014; cv=none;
        d=google.com; s=arc-20160816;
        b=NV4qVgmBYxRrREbah1ZvMgf3H0jVwGsrUmjTouaGMsc0QVLHRzVY1iZr6xGDiWiI7M
         R211ZAVOurWPcehNVZGv1jcD8X0PgaNo0kEzxwGwa4XNtpT7eC0lf6/bHLRp4gzEVoj5
         Rtpywqtzm/pbAX92IciZqHgmqySBq3dt1G/I0y+Mu8kwhds3u53TUV0acSdxkQeSoBGD
         NPAYC7UGcUe0bCbuLyRx15N2lOXtwuVDrJZJ36Pz6IW+6+1+VnCZa8gG6vamHQX3VJQZ
         62HEwITnJnFsYK2MvSBYBbeszVrU5H0YdTdrXbgq8T7IPC9a/HX4cNywmAugubcH37+Y
         PrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LT7PvvZRhZZRExTU25nGX3a3Mk1GYBRHLnp8shtCy/k=;
        b=OgdB787AmZEwdx6kX0J9P2y+s9cmq5O5o4to63MFsWiOjKhDOWGeYpIA9WXRPXZkm8
         XKb164sFMnCbBPEr1MlmVRM5OGcrTDT9ONWVEtGXpyGANphE+HzsYuPLX8xIC3hSv+UE
         Auv06XAX+xFKQnGiYuUnVyijtE221HqcoTaiwNabhvnPkFiSSx9RiqvgW3IxWkDsm3vx
         sr4de3Rc4rgJ1QtNbcxJXiHx270ytmj6O6hmwA/fzlwcbcb2YZEBfGRor0rdLxJybLX7
         ZV85UCRAwmngVaHw+reTkapD6oSb7jjiCspjkaTxCmNJ2wY5+V9NydnuPW2OhDQBg2I9
         IvfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 63/67] Fix slab name "biovec-(1<<(21-12))"
Date: Fri,  6 Apr 2018 15:24:33 +0200
Message-Id: <20180406084348.612700208@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004122031445123?=
X-GMAIL-MSGID: =?utf-8?q?1597004331403836019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit bd5c4facf59648581d2f1692dad7b107bf429954 upstream.

I'm getting a slab named "biovec-(1<<(21-12))". It is caused by unintended
expansion of the macro BIO_MAX_PAGES. This patch renames it to biovec-max.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v4.14+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -43,9 +43,9 @@
  * break badly! cannot be bigger than what you can fit into an
  * unsigned short
  */
-#define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
+#define BV(x, n) { .nr_vecs = x, .name = "biovec-"#n }
 static struct biovec_slab bvec_slabs[BVEC_POOL_NR] __read_mostly = {
-	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
+	BV(1, 1), BV(4, 4), BV(16, 16), BV(64, 64), BV(128, 128), BV(BIO_MAX_PAGES, max),
 };
 #undef BV
 
