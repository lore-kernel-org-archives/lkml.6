Return-Path: <gunthorp@deltatee.com>
X-Google-Smtp-Source: AB8JxZohrBgZ4Elkd3RKYxDVKDKcaOn2jJjsdPR0tf4UC6Su92EmYp66V3o4Cc18cxnvGYeRNJT8
ARC-Seal: i=1; a=rsa-sha256; t=1525725376; cv=none;
        d=google.com; s=arc-20160816;
        b=wUWJfHsGpH7QOW2chGXY2RPJCj5ETJ2PrNkQNBVqQWLD486qbZALwmWu8zFIb+4g1X
         AX+ZGpsCrk75MBZ9ztXjIfT3bHPZm6UpxQS96T0uR2G8xJnHH0Kfg5Qs/NXrutDpwFnT
         dlwGwlTXL5ZINfHB/19C/lPoT+MmcC2slWMU2Wt/j377jtCi77YofjAEob+LsJXOGtX6
         Wc2uPV9LIiAXmaEvMlu4G5lhE1kkfwes4iqmumNLE6L+1VOBs3+O+qpytwwxp4SYGV3n
         ZP0Wl0XJ/y0YB5qCV7e19wqdRZgv1UITvmW9JlOTi9dFU2GCtoPz1iGcsXc8dgMQc28o
         YurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:message-id:date:cc
         :to:from:arc-authentication-results;
        bh=gvDG//YQSQ+80Nc2XfONqWG/QuF22fHWzKQPk5tPu/k=;
        b=Y7cLrOMHd8ZTOklCFozzY5I4l2xZCHKMc3F9ABaxmqewOIV5PnRCaT2mtjsQASVmn8
         gq79vPNEgSN0onezP0pom09RXm2itkYLDAmkaJ5rQXxVscKmMGPs8G4HP9uQJvdmLmPf
         WsjWHQvtXF08iMxo0xEuz6aH62CYydDTAJzawFeHWEU07negSvKQhaEiZl4L6SU0l/9E
         9wrcwHaW4X5UEi4IlxHUdhCss3z4g3MXxQ0T3uigPO1kOYJERzFLCQBAEV1EHLD74uKI
         7n87VRLIKi4ARK0Ps5SJDkhgHFQP0Yvt6NDkhNbypQuWpcILXlj+85ESs0bxK2YaRwEI
         DVxA==
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
Date: Mon,  7 May 2018 14:35:58 -0600
Message-Id: <20180507203605.15865-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de, gregkh@linuxfoundation.org, andy.shevchenko@gmail.com, horia.geanta@nxp.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v17 0/7] Add io{read|write}64 to io-64-atomic headers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599839011980370630?=
X-GMAIL-MSGID: =?utf-8?q?1599839011980370630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a resend of my cleanup series to push a number of instances of
people defining their own io{read|write}64 functions into common
headers seing they don't exist in non-64bit systems. This series adds
inline functions to the io-64-nonatomic headers and then cleans up the
drivers that defined their own copies.

This cleanup was originally requested by Greg after he reviewed my
Switchtec NTB code.

@Andrew, can you please consider merging this series as it has a
number of cross-tree pieces? It has been around for a number of
cycles, has had some reviews, and a few small pieces of it have been
already accepted through various other trees.

Thanks,

Logan

--

Changes since v16:
- Rebased onto v4.17-rc4 (No Changes)

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
