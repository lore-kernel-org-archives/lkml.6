Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AG47ELslUK++Se+6M8YPwYmcyzACvxPsNmF8CXlXRaZauItgFEbBqWsNXxnMfgqQ3GBb3mzRQSap
ARC-Seal: i=1; a=rsa-sha256; t=1520276925; cv=none;
        d=google.com; s=arc-20160816;
        b=jvcXQQhQ8mko7hyK65fiBO3yBdBkLDb/Zauu/g8DPmO5L+M6QLkAIPwdPmKjdU95ry
         iH0KJw++FvPlH2Td38bbp8K6Gpq1EFHKU6J9ZpIQSViDeBeRJnHz7F4FrDBVatfME4cl
         dxbInskcabYcZlasIUewdEdXpYQihmyASayhv+GY376Tb/EFw6MieslG3GR1gWUOTI9V
         Xqb8jYupQdAj9VzbxnY8lek6ka12jzgNNs/to6heYbP7KvHX8Cew7NgzYLVamfl/BjFH
         xaYy9jO79mPY71lO8uAkxW3DECixuz9md60Lts0mTe1XJh7NrtnwMBlIl9XCGwnBLBUO
         zy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:message-id:date:cc
         :to:from:arc-authentication-results;
        bh=oIX2nAsexPikrMu97v1Mwypz+qi82vc+L8t/IuSePt4=;
        b=fK5xfFr2COhP6pd9IUlFXgvt87CClpg554aDIzfocGIA40jL6xGdRKHaVhzw3LKkA2
         Y8MNkySZzTI/BWtqCZofb1Pa5fzoxw/nf5cFQKaJULjnxhjEh0VOjMsVen+iy2DwL9Xo
         PWK7lBElOeYG92l3gXoggNMtO1yDHdxuQozuT3nuGpTzx1rB3ERYJOoLTWP2yenJmWt6
         +5fa3Pg003Quqge1gv9jyZ5T38wx7RWOzweJRtzRq73AqDI7GmMBbtt3O3+EDVAHzft9
         joOuFOaafYnas4mgBvuHChIcya+mcgAvv/yLUZPevYxIJWvPnNowzSaKKyCb8KXWzzwK
         C0fA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  5 Mar 2018 12:08:17 -0700
Message-Id: <20180305190824.847-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 0/7] Add io{read|write}64 to io-64-atomic headers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125897374371388?=
X-GMAIL-MSGID: =?utf-8?q?1594125897374371388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is v11 of my cleanup series to push a number of instances of people
defining their own io{read|write}64 functions into common headers seing
they don't exist in non-64bit systems. This series adds inline functions to the
io-64-nonatomic headers and then cleans up the drivers that defined their
own.

This cleanup was originally requested by Greg after he reviewed my
Switchtec NTB code. And I hope someone can pick it up or at least give
feedback on it soon as it's been around relatively unchanged for a few
cycles now and I'm getting a bit tired of resubmitting it with little to
no interest.

Thanks,

Logan

--

Changes since v10:
- Rebased onto v4.16-rc4, this droped the drm/tilcdc patch which was
  picked up by that tree and is already in 4.16.

Changes since v9:
- Rebased onto v4.15-rc6
- Fixed a couple of issues in the new version of the CAAM patch as
  pointed out by Horia

Changes since v8:
- Rebased onto v4.15-rc2, as a result rewrote patch 7 seeing someone did
  some similar cleanup in that area.
- Added a patch to clean up the Switchtec NTB driver which landed in
  v4.15-rc1

Changes since v7:
- Fix minor nits from Andy Shevchenko
- Rebased onto v4.14-rc1

Changes since v6:
 ** none **

Changes since v5:
- Added a fix to the tilcdc driver to ensure it doesn't use the
  non-atomic operation. (This includes adding io{read|write}64[be]_is_nonatomic
  defines).

Changes since v4:
- Add functions so the powerpc implementation of iomap.c compiles. (As
  noticed by Horia)

Changes since v3:

- I noticed powerpc didn't use the appropriate functions seeing
  readq/writeq were not defined when iomap.h was included. Thus I've
  included a patch to adjust this
- Fixed some mistakes with a couple of the defines in io-64-nonatomic*
  headers
- Fixed a typo noticed by Horia.

(earlier versions were drastically different)

--

Logan Gunthorpe (7):
  powerpc: io.h: move iomap.h include so that it can use readq/writeq
    defs
  powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}
  iomap: introduce io{read|write}64_{lo_hi|hi_lo}
  io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
  ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
  crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
  ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common
    header

 arch/powerpc/include/asm/io.h          |   6 +-
 arch/powerpc/kernel/iomap.c            |  40 ++++++++++
 drivers/crypto/caam/regs.h             |  30 +-------
 drivers/ntb/hw/intel/ntb_hw_intel.c    |  30 +-------
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  30 +-------
 include/asm-generic/iomap.h            |  26 +++++--
 include/linux/io-64-nonatomic-hi-lo.h  |  64 ++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h  |  64 ++++++++++++++++
 lib/iomap.c                            | 132 +++++++++++++++++++++++++++++++++
 9 files changed, 329 insertions(+), 93 deletions(-)

--
2.11.0
