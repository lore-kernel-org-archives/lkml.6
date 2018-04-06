Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49iC0wYCvyl4WfaIUp8T2ZzfoU2cP25/oYFOMga9G3BdkzDKKZBkkqEHNZFc651ttoIA7pw
ARC-Seal: i=1; a=rsa-sha256; t=1523021619; cv=none;
        d=google.com; s=arc-20160816;
        b=K1pHWA9ut9SQ/qdCbfnzEHKciigEcUGbT8Up6XaN0unvlkoVrDR0kRd3uv4GT+jbNq
         MnOS6zDdzjj61lmeYeyVGFgOH7mT5wf69CHVWjB9P7f/LxwQc0fSwkTaRvXlI1pHfyY3
         NJv1H2M24niwfpqPZkN/pX2fNiiLRYMuPmMy3cmyBrfb2DVNsXVWKHlj4szxZ8W7VhrS
         IAbifEkInIWO4kuTCOq2y188cG5tUUKFSkA1FPcBWFBUMnX0a0veV30NYtubPilNw1go
         zBEumoCvUYDFMIEbyfcAzyxs+zpUvrcU+eoq/2BCC1TRWKMnDnQOG4KMX5aKkKNZPp/W
         hEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ouT+S3CznIqnBaDlN/1zTXjTjhguu2LEZNGyzfnng3c=;
        b=Y4jfQx2yMnd0KL/6nOeADqcbhT/j/+e8uTOMXW+gy9EXvgNQCqKQC1dsGtqC0It3R7
         l4d5Xpvl7NNkvz4/vevRHPyYpqHrdx+jA23HaLJynQ/aG1Hyw9Ek3kttgRT9vWw6h7Sk
         GIr89mGAksCaBSdmrfhvHxMIbSHwadfg7Tw/BwsMHEl0F55ub9rR747noK+z1Es7x1S2
         78T9RfkbA5iyf2oxP/U7sBVUc5aQjtgLBtGX4Gj9py/OgCHI+CDuHoAMTjRv/xqO5dhT
         7RIlxjx7kkhEVAYbOXYj3lrHb/2z0t/20sPHoqFaxYiCwpfiXIqAwZAtk4zHzVRgoslN
         eXYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 029/102] mac80211: Fix clang warning about constant operand in logical operation
Date: Fri,  6 Apr 2018 15:23:10 +0200
Message-Id: <20180406084335.741649547@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003917438569471?=
X-GMAIL-MSGID: =?utf-8?q?1597003917438569471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 93f56de259376d7e4fff2b2d104082e1fa66e237 upstream.

When clang detects a non-boolean constant in a logical operation it
generates a 'constant-logical-operand' warning. In
ieee80211_try_rate_control_ops_get() the result of strlen(<const str>)
is used in a logical operation, clang resolves the expression to an
(integer) constant at compile time when clang's builtin strlen function
is used.

Change the condition to check for strlen() > 0 to make the constant
operand boolean and thus avoid the warning.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rate.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -173,9 +173,11 @@ ieee80211_rate_control_ops_get(const cha
 		/* try default if specific alg requested but not found */
 		ops = ieee80211_try_rate_control_ops_get(ieee80211_default_rc_algo);
 
-	/* try built-in one if specific alg requested but not found */
-	if (!ops && strlen(CONFIG_MAC80211_RC_DEFAULT))
+	/* Note: check for > 0 is intentional to avoid clang warning */
+	if (!ops && (strlen(CONFIG_MAC80211_RC_DEFAULT) > 0))
+		/* try built-in one if specific alg requested but not found */
 		ops = ieee80211_try_rate_control_ops_get(CONFIG_MAC80211_RC_DEFAULT);
+
 	kernel_param_unlock(THIS_MODULE);
 
 	return ops;
