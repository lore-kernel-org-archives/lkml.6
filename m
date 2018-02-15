Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226rDE3J4DMoMAwLkRDXwTEMdB87TjxaRMhjdyGWqqOIKLaNU8IYcYbB4S7W2F5zgKTS9t/n
ARC-Seal: i=1; a=rsa-sha256; t=1518709177; cv=none;
        d=google.com; s=arc-20160816;
        b=NmNkndaDXCwtVB0Wl+cNwQPLUxuEt3WS1fCuMMJnxwePxYY4oYYbqt2keDg+ymeFCL
         QIuIk81qOLW8l7lypWpWGpQDKxvYLSFBUYGaNEG0sZzT6O4Q3tJ7qfAtmBzzGjhyuaox
         6SCWzAOmg7OmCnJg63Unmb6c2Z2Xnr+KLPvZCvGvNzC0sVA2DrT4d0Ve6vvHwN/Hube2
         W+ZEE3TmkfAnDjYErF5lVens9qL4cbtK5PccJlk68rOBPsiVNOxNklwJuRD9KCp9F/fC
         0HkVEoVFb2NfLyZbeMousBDDq2cmGAykg2eiUuc8daWxOKj1OwyMQ3KFtV1iWpw1UECX
         vvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vwb5dWjoVNkxRKMuQOvDbxUnEJdtofQZcrI32wnknyw=;
        b=S0jf4X/VbNXzit37IIX39tik4ML3OSwsh0u67JYQJxuwTRTDUx+Uioc02uEjMFdOaB
         /DZeb3SGV0iwzpsx+Mg0mf5SrHc0UupsLxIUypQMu9Birf2j3xdJ7siTfLr0WznWmtgY
         It2rq88qFgNX1V6k+C3UqzVg8QBn3sKwoa0HLe/I15voowkpf0eixc08cWWdyde+uDCr
         L0xqyCBoEkgJqpajDYlCjnctuL3ckbk4H3d2YWaDnaVpXdbKSN8t+Q8pnm5Wy8/ZCILC
         UTiYX7TErUJAd96zltzkLXL8ZsuE3QaAwfzcB16DdP0rVW61ouCPNwjWD1oUp3XbjXG/
         HohQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sven Joachim <svenjoac@gmx.de>,
	James Hogan <jhogan@kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.15 007/202] ssb: Do not disable PCI host on non-Mips
Date: Thu, 15 Feb 2018 16:15:07 +0100
Message-Id: <20180215151713.185121068@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481995086939018?=
X-GMAIL-MSGID: =?utf-8?q?1592481995086939018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Joachim <svenjoac@gmx.de>

commit a9e6d44ddeccd3522670e641f1ed9b068e746ff7 upstream.

After upgrading an old laptop to 4.15-rc9, I found that the eth0 and
wlan0 interfaces had disappeared.  It turns out that the b43 and b44
drivers require SSB_PCIHOST_POSSIBLE which depends on
PCI_DRIVERS_LEGACY, a config option that only exists on Mips.

Fixes: 58eae1416b80 ("ssb: Disable PCI host for PCI_DRIVERS_GENERIC")
Signed-off-by: Sven Joachim <svenjoac@gmx.de>
Reviewed-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ssb/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -32,7 +32,7 @@ config SSB_BLOCKIO
 
 config SSB_PCIHOST_POSSIBLE
 	bool
-	depends on SSB && (PCI = y || PCI = SSB) && PCI_DRIVERS_LEGACY
+	depends on SSB && (PCI = y || PCI = SSB) && (PCI_DRIVERS_LEGACY || !MIPS)
 	default y
 
 config SSB_PCIHOST
