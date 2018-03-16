Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELucWojMw7yQ0yBI3VSNXYKA7AZBBuGV04HBVTKWnTM0Xdh1V6/xD7odIiXv3Q9TII9bUXXE
ARC-Seal: i=1; a=rsa-sha256; t=1521214874; cv=none;
        d=google.com; s=arc-20160816;
        b=ClPEh6y/MmPjE9UwjFwQcKrzJ0gha5a+DFw7FMIsCKG21EMtD/F5RLlVecDCueT2is
         RQZOyfx8fZUx3ZbJ7oFJSKTfK2Bdrqn5w6ry97kSmlXPKr3kCM2gOHfr5phwUEjSTjg/
         L2ym5FqmSFclw5bcX0oxKECtPdlUT3MLSA6xZcOmDzqWs8B0PFRZjXNDhUSC1DprQN1s
         xhxD3xdtxSzV9anEv7R8/867Fu++3jdwXw9h2poA03C1EXxuJctfS7Vnkn+tsFNseCBD
         51pfJcmZo2RleGXlXFrtf3TOxdHcQ7WPdC2SrAZeta6An0CSkmb7F/sV8Uw3StQwKPWi
         fL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vBYzg1bJNIS0KASnz3M3LslSLgu3dh2llWhjABXH4Ic=;
        b=ciRzIJiFqzCbxLjMhOhydqxzMdFfB9EmJBo40G9Yczejfvk+YHa7M+l+32own+DUYs
         P0c76hcTNxz8GVvwxrMnia0rnFPvDwVJ4Cz14aPYpIxOK8wNN73TIyTLdKxVBfQNqkGL
         c8+E3ND9j+2kZtYpZHFv+f/5OtN6bzLDw578w8tuN/Ko7ozCsQn9J+hbmdp2FiFdA7xT
         17Rd4YhRIGznej6hsmTWZLAmAIIPvCXnwfOkhgVAp/jYsclf3sNcxnDE8zdzkr3Q/qBR
         s/xqE4JKPVZD7mFdKO1+0aHLeDNHs7aJZvgYJMOv54Br3xWbtZWOH0/x5mvg+kf29+gS
         utLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pierre Ducroquet <pinaraf@pinaraf.info>,
	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 049/128] crypto: ecc - Fix NULL pointer deref. on no default_rng
Date: Fri, 16 Mar 2018 16:23:10 +0100
Message-Id: <20180316152339.283206824@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109054048113937?=
X-GMAIL-MSGID: =?utf-8?q?1595109407711523203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre <pinaraf@pinaraf.info>


[ Upstream commit 4c0e22c90510308433272d7ba281b1eb4eda8209 ]

If crypto_get_default_rng returns an error, the
function ecc_gen_privkey should return an error.
Instead, it currently tries to use the default_rng
nevertheless, thus creating a kernel panic with a
NULL pointer dereference.
Returning the error directly, as was supposedly
intended when looking at the code, fixes this.

Signed-off-by: Pierre Ducroquet <pinaraf@pinaraf.info>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/ecc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -964,7 +964,7 @@ int ecc_gen_privkey(unsigned int curve_i
 	 * DRBG with a security strength of 256.
 	 */
 	if (crypto_get_default_rng())
-		err = -EFAULT;
+		return -EFAULT;
 
 	err = crypto_rng_get_bytes(crypto_default_rng, (u8 *)priv, nbytes);
 	crypto_put_default_rng();
