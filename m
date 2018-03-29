Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/4zcppj1hQfGsNMdLB7V5uBqEZViQthIZ1s4pHbH892kzgmQxxHgKKOUa55buk6zBNFs/S
ARC-Seal: i=1; a=rsa-sha256; t=1522346718; cv=none;
        d=google.com; s=arc-20160816;
        b=ifwaaaR9PZ/FrCgUvvREJBmRemHc65JNUyHL18MzPu00x/AcyCmL0vFKwodU5path4
         OhgtzBJ7nmtxe3kTh7K5uf4DzREDm2eHfLwg2gSw7ekJMIvBYdYTay8P4qabRr5ZsWpy
         FE+xXulg5Qyx8OXXqFpzbtm7MVVP4vmJq2lMGWY1bPYn06cSIiyf3DGK/epOVEI6MEMm
         rUlQ0ORTSbfNMZCUOPxIQEM6qq8FjL82nTjl04fFhDfICzjsus4NPHk2cmVCe1AIRFMj
         nTNcXqfk/INztouGN8MMTlbhmLoGWVhavYS865eJ035/lXnoae93GBv7P+a1WUEu7HFU
         yZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5qMZgB4Sz6+CXqLuwvdFetWoyF5VsgT3j/EcbYA8Rso=;
        b=z7SirxrUadomKrWlzvzunMAX8rKDigPELNEaHbjdjo9iBPpgje4G9yFGKmhTgYJqDP
         ojyKobhyo6WUkcpRTjrtdGpFFIQ7cziYhuUGZqLTEvPNBj/OMbqchvMlbXjqOSNpheCT
         qG1IjZU8G/lPv3SkpVXJSlj4k4i7eQkNhjtCLosftMrM24L/e4q0eCLLCKQDBpCH0Bng
         XdoC6WIWdRjZOKrstQVaLATteKqzWBM5ooPZPegFfH/Yrcgd7a2t3nOW8reo09mfn9Am
         0XNnP3vzf5rLhvAQUgP9+2pc0yJEVuld8U3LKbWYkr29h3E0Adh9qWtWdmElfiBDQnvN
         QRsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 34/43] team: Fix double free in error path
Date: Thu, 29 Mar 2018 20:00:29 +0200
Message-Id: <20180329175733.806830645@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296150991249448?=
X-GMAIL-MSGID: =?utf-8?q?1596296233320005745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arkadi Sharshevsky <arkadis@mellanox.com>


[ Upstream commit cbcc607e18422555db569b593608aec26111cb0b ]

The __send_and_alloc_skb() receives a skb ptr as a parameter but in
case it fails the skb is not valid:
- Send failed and released the skb internally.
- Allocation failed.

The current code tries to release the skb in case of failure which
causes redundant freeing.

Fixes: 9b00cf2d1024 ("team: implement multipart netlink messages for options transfers")
Signed-off-by: Arkadi Sharshevsky <arkadis@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2394,7 +2394,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
@@ -2680,7 +2680,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
