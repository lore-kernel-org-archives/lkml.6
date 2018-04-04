Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AIpwx49qsW8TMq5PPvODhuchVWbLf8vUmE/IS6/KNuMuRDU0jhnog/raaKxxI+UmemivrgZFbPUL
ARC-Seal: i=1; a=rsa-sha256; t=1522856887; cv=none;
        d=google.com; s=arc-20160816;
        b=tFjzW0OeFSA/N0bOOXVIE30pH3LOlplmyQbRjYPIbKwNgPciEl4MoVTC51EgXLw3ya
         zhwe40i1lbbrvWtSXe60zZXMOvwE3jCC7oIllblC7MwVVUib2BUKTcoUO+sA+/3EUhSe
         qRQWzYL02agR+3bSiyPcxXHsxjZ+p8KefaDpX9Mq6lBPq9g+tNziYc5daMNqdJWJfrVA
         PyYvm/bbE0YerKKkVoq6BNuKZnkW7BI6Uo7IPcfo8/ig9LUMeWZA/zphNmi8rLOp6c3k
         ACQ7DJNajR7CM1HrPJedAeh+FaSrrJ269Hs4NPoQMQAejn395/UqSVazLsEjM9QVv2XO
         JzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=qbhVeasr8/dfLLK3Kx8NRT7TfhFOqx4yDXMopn1QpUA=;
        b=OWvozFj2Cw031iubXMLGM0Ihdd2aG/SjRf0mCVwb18MpnBl4EPCK4CzItm00BOneoz
         oDCuK3CRVToaktMbm13APyPJBLgqTuOkOfUTrfOYig2VR9T8PWMTCzICV3ZJRVjYGJfY
         2TkJWKzBdftVkgINKhwodpPHjU8HnCd5m7IRchunCRZVPRuB5kqlBSEY/71lec4E2ng2
         FixqxxD5N85IS918zW3NONg6uYTIGF1fQivqoF5M0WzA7+/3oPU9YaAz088CBxyjwJan
         swGv0hUTFuIBjP7PcQ8yJ5WkXUmRrmK8VrM9pmFAhwh1O6y5YDp6wRu0VdJB0ZwHfAzt
         NSVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Wed, 04 Apr 2018 11:48:04 -0400 (EDT)
Message-Id: <20180404.114804.662817136963950531.davem@davemloft.net>
To: arnd@arndb.de
Cc: srinivas.kandagatla@linaro.org, mike.looijmans@topic.nl,
 f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, o.rempel@pengutronix.de,
 martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net] nvmem: disallow modular CONFIG_NVMEM
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180404103900.4090118-1-arnd@arndb.de>
References: <20180404103900.4090118-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596811748893246991?=
X-GMAIL-MSGID: =?utf-8?q?1596831183018267047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  4 Apr 2018 12:38:40 +0200

> The new of_get_nvmem_mac_address() helper function causes a link error
> with CONFIG_NVMEM=m:
> 
> drivers/of/of_net.o: In function `of_get_nvmem_mac_address':
> of_net.c:(.text+0x168): undefined reference to `of_nvmem_cell_get'
> of_net.c:(.text+0x19c): undefined reference to `nvmem_cell_read'
> of_net.c:(.text+0x1a8): undefined reference to `nvmem_cell_put'
> 
> I could not come up with a good solution for this, as the code is always
> built-in. Using an #if IS_REACHABLE() check around it would solve the
> link time issue but then stop it from working in that configuration.
> Making of_nvmem_cell_get() an inline function could also solve that, but
> seems a bit ugly since it's somewhat larger than most inline functions,
> and it would just bring that problem into the callers.  Splitting the
> function into a separate file might be an alternative.
> 
> This uses the big hammer by making CONFIG_NVMEM itself a 'bool' symbol,
> which avoids the problem entirely but makes the vmlinux larger for anyone
> that might use NVMEM support but doesn't need it built-in otherwise.
> 
> Fixes: 9217e566bdee ("of_net: Implement of_get_nvmem_mac_address helper")
> Cc: Mike Looijmans <mike.looijmans@topic.nl>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The problem arrived through the networking tree, but it's now in
> mainline, so the fix could go through either tree

Ok, applied, thanks Arnd.
