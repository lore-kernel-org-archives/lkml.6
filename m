Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZqj+4pQLyDaDC+2X1SXRNF9RAEknO0DyZ/qH1osMaDPxBUQx4ZmAzvSRmGDiiDgc8+tyZSa
ARC-Seal: i=1; a=rsa-sha256; t=1526486897; cv=none;
        d=google.com; s=arc-20160816;
        b=P5L0MCQ3HBIJZwY/nyiQ9h0YPdMQx1ndr2okVZGUv+1jxOCC4YbTbKejS0ZU2AzuOD
         EvoITCaUC5RMwToVjJc1yxraL3pmYL64xJi8BNEPP8ek2bwiicjvy3nT8NxbLciHcuAG
         Vhj4DXt52F93ITbVHaBDkQromb0C0nwijP1Xd8lKDbz35INOAHSXsJCkxIikiZ1yLn9T
         M0jCRlmonc97+t2oHo9CrcElfzZABleQMBf15RdirNg/J6fdrwPLBTEWC4pOkcc0xDRo
         l05Qlqunjs4/ZeOwoVkb5ZgS593NvhhfrlegQtL4RO4nfCrMN78Y4EwBWq4KhWH0h0/C
         QJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=MJS+f0nrzncm5kuMS18euq+B9lEBZxk1HaGrHF8WrhU=;
        b=JWNCuTIUVF44Z/iGejXWohJkqXUvvNLClqb70LcgFpQgxMa5Fh2Fb4B/Zsfzn3Apxc
         LS5UIVJtICOXyFmirCfuegzBq/jb/G2LZwnfhz8eRuu+cexNoZka+03O7pPi0FtXFQ7M
         LLcCSvB2LsbyYaUHlwqAdq8TJYzHcAQIrdW75SN+EoZkHo8fbJT2+xKhkKHhU2O2ayCS
         OOTE2GqivLq7ofNjTKcYNziojjNLxyxbBG1wMItKbX8w/5x7boEwOzLrGP9DomFt0Xy5
         6BaLfKA/FpIAOR3RVDPJAn8urbAoqyGsb+Pg+o+W44ePVgaFyFPEKAWEJcRR6a0BxFbF
         qUug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 5.45.100.158 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] return EINVAL error instead of BUG_ON()
Date: Wed, 16 May 2018 18:08:13 +0200
Message-Id: <20180516160816.20251-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180516120527.29403-1-flo@geekplace.eu>
References: <20180516120527.29403-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538306192171209?=
X-GMAIL-MSGID: =?utf-8?q?1600637524950937022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch series makes driver_register() emit an error message and
return a failure code instead of triggering a BUG_ON().

The first patch will cause driver_register() to fail gracefully if the
driver's bus was not initialized while printing out the name of the
faulty driver *and* the name of the involved bus. The second patch
records the error code if bus_register() fails. The third and final
patch of the series extends the first patch so that the recorded error
code is also print out if non-zero. Otherwhise, if drv->bus->p is NULL
but the error code is zero, then probably bus_register() was never
called before.

Florian Schmaus (3):
  driver-core: return EINVAL error instead of BUG_ON()
  driver-core: record error on bus registration
  driver-core: print bus registration error value

 drivers/base/bus.c     |  6 +++++-
 drivers/base/driver.c  | 12 +++++++++++-
 include/linux/device.h |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.16.1
