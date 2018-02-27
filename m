Return-Path: <benjamin.gaignard@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519740581; cv=none;
        d=google.com; s=arc-20160816;
        b=LcbZLVrP+EZ9EjVIhB+tyvwfNzheGImk5BCs8I7rKp2HgcmuS7x5lSasFH3ilRf91M
         dkz8vg8qYZ7cKreP9poCZ7ZQiztRBM+Ebs9wh3W+I2W89lJT1lU8KhfRsProwk8nL02I
         D3rc2OUG2ZG11glLrdR61x00J/RRUpyHn38UVaBq+/GlK942FVXkApkAXQo9uO3aihgU
         y7GwQh/7U7T0z6FrZa9W9wgFE81PJP1zu0Ewu32f5IAKfPzTxlurEeXq06luDKLo9NXr
         ZxNfdrPTmAz2KcKebmS/R0+E4tcpfLfU61NYZJTM6QQrNyLhZtVe6wXrjqLfDz9BbUVs
         FKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=5P6rQr4UYrqvIjgnlkXSFF1Pc7pk/CuSRZQV+Xv0Mes=;
        b=0ygtW7oBw+zRQPpGyHfkKc+nsG0ooAV2PgjtKE9wxbpewMmVDxkAadsDIjvCbT6q4T
         1zyPRQ+dQf3QgBl0XJC9pwhnUlVrcmJgGQ5PY+KaqIxVsptSiPQse2/hEGrBMQjmpQa/
         bv43pCMVRzhkipSgQY578t/b+Sut8woXpEJSOLy7ef24sWlpe7is1g7bSoIdmQ7feHD3
         SGs1gwPo0prJnCr33bsibu351Rwt55PTMBlQLJWF7w6DkNstMB/+QH1BCgMB4SN8QIUy
         2r3O5LD4roFJvnvCsisCstKDkFZ8cw+ptEFQdhIPqfCh4ZpO3jxm8+1p60kkGw0smIlM
         3zYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=S3HSwc98;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=S3HSwc98;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsRDAHAJPUhPvrsSK64fgnS3N3YorblmM9amqYD/UVpUfVHorsiS6j7k9vuxE/64lwdvmJ/fw==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@st.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/3] STM32 Extended TrustZone Protection driver
Date: Tue, 27 Feb 2018 15:09:23 +0100
Message-Id: <20180227140926.22996-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563499941739218?=
X-GMAIL-MSGID: =?utf-8?q?1593563499941739218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
to a secure OS running in TrustZone.
We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
because read/write access will all be discarded.

Extended TrustZone Protection driver register itself as listener of
BUS_NOTIFY_BIND_DRIVER and check, given the device address, if the hardware block
could be used in a Linux context. If not it returns NOTIFY_BAD to driver core
to stop driver probing.

NOTE: patches 2 and 3 should be applied only on
git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
but until this patch: https://lkml.org/lkml/2018/2/26/386
find it way to mailine KBuild will complain about them.

Benjamin Gaignard (3):
  driver core: check notifier_call_chain return value
  dt-bindings: stm32: Add bindings for Extended TrustZone Protection
  ARM: mach-stm32: Add Extended TrustZone Protection driver

 .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       |  13 ++
 arch/arm/mach-stm32/Kconfig                        |   7 +
 arch/arm/mach-stm32/Makefile                       |   1 +
 arch/arm/mach-stm32/stm32-etzpc.c                  | 252 +++++++++++++++++++++
 drivers/base/dd.c                                  |   9 +-
 5 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
 create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c

-- 
2.15.0
