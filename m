Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AIpwx499d8virLnnkVD+Kj7CF3oEicAhhP14hZLBv9K426Bn3VBYzk4eP0pIaZw/sUhIPOLIRxgo
ARC-Seal: i=1; a=rsa-sha256; t=1524248659; cv=none;
        d=google.com; s=arc-20160816;
        b=S54mi3ZbJpW303jtHMnNdOKotPU7AzyGspnPni/4xX+lX8cUEGx+dXBPeCzaBL20Fr
         mpvwO/CF5x6lS7GGcTVfOy6k064LaBbfp2tgHdHU9bvuu6fqg9ZMXMeSoiFJqHlXuxO/
         JcqYTosII+4+YziPdHjb3WPBeXUzn9FAHGMAFn/8KOTjrSOUftwie5Ublx5PYPn9VSaZ
         CP+ATQREnwEIa02nR8V/TIoKJkaJlMY5mnWnbkjx/zsbx16n7Ch9T9Z65t2YSlxgYBSv
         pwhlXsHN892If5CMMd4Ihei2fYPGgk6VkGRieuwHARGlq0e3Tpq/37529J4loBWZe0TL
         1/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:message-id:date:cc
         :to:from:arc-authentication-results;
        bh=8qpD2li05HFOL9rU/93kD0D8qGDpH80i2T+nDHbT4CA=;
        b=a/wL6lytlAUDqOUP/EXjvbywYJhZ39waIzyf9dxmfGgOxWOn6o1rnyTfUJ+bn2KT5l
         9qZB7XC5tfIisln4JjNR8XbTUv7/38KhAL2EDGOX14H5Jlg0HdIGJx0HgN+Y5Ri8m08I
         rRiXsig23aEJozeQiDl8We1z0MF1wQrgjTVV6pAmbtfYU2i4vPXbCDsoripqG0T7iKsY
         14ziPvBByV8sWIVkuxTtVCDC1E2oT2m/+gnVqeFuu3mAjXPcdXC8oOi26UwIen9uIqDV
         12usBl0tC1W5Qe96chwjE0D5/K/ztmDYrmPSIhkUrxkrG71hsR5k2BKRWPspvvxjteQs
         ZN5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gunthorp@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=gunthorp@deltatee.com
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-ntb@googlegroups.com,
	linux-crypto@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 20 Apr 2018 12:23:56 -0600
Message-Id: <20180420182403.9691-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 0/7] Add io{read|write}64 to io-64-atomic headers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290562382737128?=
X-GMAIL-MSGID: =?utf-8?q?1598290562382737128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is v14 of my cleanup series to push a number of instances of people
defining their own io{read|write}64 functions into common headers seing
they don't exist in non-64bit systems. This series adds inline functions to the
io-64-nonatomic headers and then cleans up the drivers that defined their
own copies.

This cleanup was originally requested by Greg after he reviewed my
Switchtec NTB code.

@Andrew, can you please consider merging this series as it has a
number of cross-tree pieces? It has been around for a number of
cycles, has had some reviews, and a few small pieces of it have been
accepted through various other trees.

Thanks,

Logan

--

Changes since v15:
- Rebased onto v4.17-rc1, dropping the powerpc patches which were
  picked up by Michael

Changes since v14:
- Rebased onto v4.16-rc7
- Replace the first two patches so that instead of correcting the
  endianness annotations we change to using writeX() and readX() with
  swabX() calls. This makes the big-endian functions more symmetric
  with the little-endian versions (with respect to barriers that are
  not included in the raw functions). As a side effect, it also fixes
  the kbuild warnings that the first two patches tried to address.

Changes since v13:
- Changed the subject of patch 0001 to correct a nit pointed out by Luc

Changes since v12:
- Rebased onto v4.16-rc6
- Split patch 0001 into two and reworked the commit log as requested
  by Luc Van Oostenryck

Changes since v11:
- Rebased onto v4.16-rc5
- Added a patch (0001) to fix some old and new sparse warnings
  that the kbuild robot warned about this cycle. The latest version
  of sparse was required to reproduce these.
- Added a patch (0002) to add io{read|write}64 to parisc which the kbuild
  robot also found errors for this cycle

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
  iomap: Use non-raw io functions for io{read|write}XXbe
  parisc: iomap: introduce io{read|write}64
  iomap: introduce io{read|write}64_{lo_hi|hi_lo}
  io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
  ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
  crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
  ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common
    header

 arch/parisc/include/asm/io.h           |   9 +++
 arch/parisc/lib/iomap.c                |  64 +++++++++++++++
 arch/powerpc/include/asm/io.h          |   2 +
 drivers/crypto/caam/regs.h             |  30 +------
 drivers/ntb/hw/intel/ntb_hw_intel.c    |  30 +------
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  36 +--------
 include/asm-generic/iomap.h            |  26 ++++--
 include/linux/io-64-nonatomic-hi-lo.h  |  64 +++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h  |  64 +++++++++++++++
 lib/iomap.c                            | 140 ++++++++++++++++++++++++++++++++-
 10 files changed, 367 insertions(+), 98 deletions(-)

--
2.11.0
