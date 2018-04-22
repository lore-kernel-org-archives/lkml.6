Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+yxClmEgeq12Yj+5LCuiO9uNsOaUCFHDZT9cvhraeq3tLUdTD/A/hshQq8kGTTPxChvYlw
ARC-Seal: i=1; a=rsa-sha256; t=1524405998; cv=none;
        d=google.com; s=arc-20160816;
        b=tTkTLXDL5GNan5voXeqMVpgJynXxsqZrCy0tCACLT3dTUEpScskMFP1H9UtR4EK0cv
         zh6cTBPlllqK+Y7k0wDuegiusCYIVb8XZXEK3POFuSog3IaqcPY2MMaHEkhDH0B+BHkO
         jDpEe/Vc7okFvgQL8BGR8a7tg5Q6BmUwufsE46z8CChWJud5CJLVG4Z16aA2zM2oZ9BD
         7lL2a9hxMUHa3Sby04cmqugUdtF2hrQfAGPQ2pXq8o60hBgZWK1PdzRrlGYp4hCpugET
         02AfEwjmRjNq3H6VfIT4TvmrN42UeVbZnqZwR4ZQLvOikCrUyKRCeqN9VH9R4w98LMJS
         3drA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LsGV9MTYlhG60O5kLUd1JhNKF8Q5kW7E7L+WCHQx8Rc=;
        b=EiYOquxEVNVcWh1GNruVYQA9+vcz+mr9mZW9IGGgdeNmW6Wqw3wUUKuemsZe+UMNoZ
         YahEs8NmVNVLTCagq0DShhSY/HqJTZ72VT7uAQvYcO6tLKrzbfrwLDLz1dgbOdK77CSy
         3+VpUEACgYy3n8d4HFjr0GU/f0jAKI99/ZcTMtMvebWR8nD+iikOv431ZZhHE/ofGfMx
         SOkeUsLlh+w4CV/Np1OIBJS7QUwUEE6uwu/RyzFiMyqLza+cT/ivA05RfktEqEyipw+r
         jPZ+L0Nz+LOpPNrvMlRKVlHWljqngm6JeHnzpwquK4Zp2Bh61+dGVycoHPS17OO00a8m
         Wxvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 4.14 068/164] random: use a tighter cap in credit_entropy_bits_safe()
Date: Sun, 22 Apr 2018 15:52:15 +0200
Message-Id: <20180422135138.249450379@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455123510525294?=
X-GMAIL-MSGID: =?utf-8?q?1598455544474091599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 9f886f4d1d292442b2f22a0a33321eae821bde40 upstream.

This fixes a harmless UBSAN where root could potentially end up
causing an overflow while bumping the entropy_total field (which is
ignored once the entropy pool has been initialized, and this generally
is completed during the boot sequence).

This is marginal for the stable kernel series, but it's a really
trivial patch, and it fixes UBSAN warning that might cause security
folks to get overly excited for no reason.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Chen Feng <puck.chen@hisilicon.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -732,7 +732,7 @@ retry:
 
 static int credit_entropy_bits_safe(struct entropy_store *r, int nbits)
 {
-	const int nbits_max = (int)(~0U >> (ENTROPY_SHIFT + 1));
+	const int nbits_max = r->poolinfo->poolwords * 32;
 
 	if (nbits < 0)
 		return -EINVAL;
