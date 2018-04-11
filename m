Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48DoPJWf3Jx7Jkx89OTVFFXFlpBi+1+tl0rgPY/JYLTzpa7uUMYd7ziVJxidDyLv/l8js/k
ARC-Seal: i=1; a=rsa-sha256; t=1523473215; cv=none;
        d=google.com; s=arc-20160816;
        b=wMVYbAyXbKw/9AXliynib6CvlUfJtvL7eZA8qpphGqf/1SCNlZaFA4gfkZkb/8ELI2
         kVznlsdYFH1J8EhM1CWE3oJiiG4bKLrLyr//GHiwr/NmkWD1wgdEqG32DqKd5IzRmC76
         4qwIZM5aML7qS8akgi/wtz+MkKLD8ipp3CeBMnLdqwcy208gKquntu1BwVWkqFh/I+Z6
         ypgBV8qnrlMCys5WseO6Nr3sYlglNGtxpiCx4PU0rchptuhXLOw/vtFBtDzBq5Ye3Yta
         PfTpoLA7an2CrtZeLjhP9zgVBF7aprXueHpuEsuL8kBa51rjjAXNjc7cJgHdKB+s3yeK
         DIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7oW0t60/KbjaJPuZhXweWw7ZGOaYP75tkn3+Jgg+UII=;
        b=zvKBAp/JaJHZBfMo49SQo1tRUv6LCHSqerJp7aeKqfmmRDKVMoXRx6z2X7TDYrEn2j
         7a4OSZuEe0J6UIbEOzZftoYrMTKcdA8NiHBb5dUCsOrEVOKZ0AlIKj/7pB9Rp8flMPow
         G/Dvf6I9dHVtWbd2w/dP0Sb7ZboGIiQjrU91RJQpkELHkj3i2pbRI2z+e+4HMWp3jpKI
         k1CfKIpfUHIvbOsUHUTFKPGFdYwiWa4virDT04w4uQLhvCNVWhOzmDqr2oYQVQg7NSfR
         tFDABZMC5EreWsD7rmsI/sEgx+eYLtSuaomwMpqkOLtO+ydEntr+itgSGBOAZd2oPQSi
         rwJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 166/310] clk: at91: fix clk-generated parenting
Date: Wed, 11 Apr 2018 20:35:05 +0200
Message-Id: <20180411183629.551810056@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477450277155398?=
X-GMAIL-MSGID: =?utf-8?q?1597477450277155398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>


[ Upstream commit 8e56133e5c7b7a7a97f6a92d92f664d5ecd30745 ]

clk_generated_startup is called after clk_hw_register. So the first call to
get_parent will not have the correct value (i.e. 0) and because this is
cached, it may never be updated.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Fixes: df70aeef6083 ("clk: at91: add generated clock driver")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/at91/clk-generated.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -260,13 +260,12 @@ at91_clk_register_generated(struct regma
 	gck->lock = lock;
 	gck->range = *range;
 
+	clk_generated_startup(gck);
 	hw = &gck->hw;
 	ret = clk_hw_register(NULL, &gck->hw);
 	if (ret) {
 		kfree(gck);
 		hw = ERR_PTR(ret);
-	} else
-		clk_generated_startup(gck);
 
 	return hw;
 }
