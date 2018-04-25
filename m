Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZp7ZbuY4xk2eq6f6KU8Spr2H1CHPBy2MSEX02aNRUbDGFUrWroUGpqqSVH+P/mWg44lSYuH
ARC-Seal: i=1; a=rsa-sha256; t=1524652805; cv=none;
        d=google.com; s=arc-20160816;
        b=DsifStu0rqpvqMd/rPO/Cs2UlBjvMPbikP6RDmkjHG9C48giUMmbJMdUgMCVReysoV
         EdzXir3FPG/BGWTr2Qjc4UMauFpV3Q3HSbp2FpK5/lbfOlmZAEHcmPv9GYrI770dgP3m
         QNfvxzcDPc0Fs9vRxr6solzIq80bD2B8ObbTDBG7RFoXDgYMgDce6eBmiInisu3lf7YT
         o/JMLbtTkRRoT6ZLg3HbTCPEVr3Zgndg9cVL84HMybV9LkXXDV8oVyAtqiXqdwzIUpSP
         02J5l403csCJuA0kLxVbhmKojePhFvWDFBaBnbdYQsvkn+oQRbuAumFUNdwhF7/g3TQZ
         pbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s96vCf6OqJV8EFfBCEgBqoF+Ixl+3ZrlWhcqwRtqS4k=;
        b=W1QxJ8kCaCvBVK4RhN3vhb3immqlQukK8YLG3nFnhrjRfO9lsBD8n2NCkrmnadNXc8
         VIE7jze8UVNhDHViDoHOU+Q+UmhSvduxHFsXKoK4+ECMlmfyiAzlajsTdOo28hqcx+3F
         VsQLYaboqlfxh7gbc3k+3459e0zldNfSVSi/Y6i/uZrCfOc+ANoAtoL0w3GGZLP1QRGh
         gXwwAALRrtTHAKRckGWMPll958i+QtVMmWnWwuqN86h64DgknWQIGT1hrrq1d8cmsbPZ
         /HV4Po+4KbvnX28imoeKtP7lVlvweO0e9HO9j4qOqhfipz1hay9BsIivFM2a969kTVoP
         VZGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 076/183] block: Set BIO_TRACE_COMPLETION on new bio during split
Date: Wed, 25 Apr 2018 12:34:56 +0200
Message-Id: <20180425103245.563519448@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714340052963913?=
X-GMAIL-MSGID: =?utf-8?q?1598714340052963913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Goldwyn Rodrigues <rgoldwyn@suse.com>


[ Upstream commit 20d59023c5ec4426284af492808bcea1f39787ef ]

We inadvertently set it again on the source bio, but we need
to set it on the new split bio instead.

Fixes: fbbaf700e7b1 ("block: trace completion of all bios.")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/bio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -1893,7 +1893,7 @@ struct bio *bio_split(struct bio *bio, i
 	bio_advance(bio, split->bi_iter.bi_size);
 
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
-		bio_set_flag(bio, BIO_TRACE_COMPLETION);
+		bio_set_flag(split, BIO_TRACE_COMPLETION);
 
 	return split;
 }
