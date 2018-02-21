Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Zz/S3mJdSc0KiYWtaVGMt+Q7V8BwfvGln2h1HZ974mFTEzvyoFpvqcuOaJk/HEsLvfQ9K
ARC-Seal: i=1; a=rsa-sha256; t=1519217894; cv=none;
        d=google.com; s=arc-20160816;
        b=KiDfWvuCw711FUMnCHv9+MjyyA2AF9BObTnyCEEZ9FwL3Xn3eBkSViJDxxeJSJUf8v
         R171e9kgS8aVMX+iW0ngProIOABOSg0AqZBH6cAXXCIZmhzNuNE8ALGToTrSitnSMTaS
         fY+OoO8MfFz4+/LdjhFI4M8gOsDkgbu0At2XhfjmD1MQC6q8MBR/Yhj+NWWSnOW4f+Tf
         6yJEmKOzgxbXr929LGumGkUTN9wvnQmxulybahyp3r43bgJMEBJQibrbPRXfBYwieg/K
         uQo3D/qScVWJ2iTRSLXp2pCtV/OADAu1L4szOZv/2UO8DxfPqszPyhtp3O+VfD33dn4n
         P9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fJXuzVnp9m4s/5YKu5VXfwWY7nm6y4gNLHInkFS+lgY=;
        b=h2jnVXg92bjoFQJ+UZWtROgLUG3wtHkQkaloLWxnYMEUSMfxSGZV3czNGrv6hyqs5I
         1EGJcLCpbp13+jwnm+n5g0Vt7CsX0edgvtTcEYS++0R5GSuwoYYHFMhbmYKfjVCnMQ7l
         E7PrfZ3dI+J0mEfZtAWbXeY+ijZdDvXkuqTKTd2zEL5FNhCb+8ZMjbTL4hvcLGad069R
         xjB2xYbJKjOzWrXg83WAks48rMtup+bYmZyf7aDpOnpQCNbFg00M2ZxA9quY0e2I55kr
         EQCSYJCSeIB6uPt1RBY+ORBlnzkYGqx6n7Fu8hHK+q7uWmAl5JXvXs6HXGIlanv2q+HY
         M2MA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 4.14 016/167] PM / devfreq: Propagate error from devfreq_add_device()
Date: Wed, 21 Feb 2018 13:47:07 +0100
Message-Id: <20180221124525.508310083@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014614609921492?=
X-GMAIL-MSGID: =?utf-8?q?1593015423257339424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit d1bf2d30728f310f72296b54f0651ecdb09cbb12 upstream.

Propagate the error of devfreq_add_device() in devm_devfreq_add_device()
rather than statically returning ENOMEM. This makes it slightly faster
to pinpoint the cause of a returned error.

Fixes: 8cd84092d35e ("PM / devfreq: Add resource-managed function for devfreq device")
Cc: stable@vger.kernel.org
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -676,7 +676,7 @@ struct devfreq *devm_devfreq_add_device(
 	devfreq = devfreq_add_device(dev, profile, governor_name, data);
 	if (IS_ERR(devfreq)) {
 		devres_free(ptr);
-		return ERR_PTR(-ENOMEM);
+		return devfreq;
 	}
 
 	*ptr = devfreq;
