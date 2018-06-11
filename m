Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6EC18C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05420208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="dqSeDH8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05420208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934583AbeFKUwb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:52:31 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41572 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932775AbeFKUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:52:27 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 989235C045F;
        Mon, 11 Jun 2018 22:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1528750345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=7BTNC4vwRe4SRL0JU8IWuwz8T27T8uBIz0Sb68l7DgM=;
        b=dqSeDH8NPEJKDlUk/XRyyHzdbJ8OqI3gimvmBoQqwuqgKxl8ITwKfWwUSVPX5DDY7ds6iE
        w5oHzBSRfgsBWQb4kKVRkZw0X5soFqX3jeOwh1eanca41sBQHL8NBa8oqKsM8Sl+WWX6hk
        5E3RWglFwn33f7dsUPBx+ULyXmHuESE=
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com
Cc:     dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        gaireg@gaireg.de, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v4 0/6] mtd: rawnand: add NVIDIA Tegra NAND flash support
Date:   Mon, 11 Jun 2018 22:52:18 +0200
Message-Id: <20180611205224.23340-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most notable change in this forth revision is the addition of
raw page and oob read/write accessors which support DMA. After
looking a bit closer into the U-Boot implementation of the Tegra
NAND driver I realized that in my previous attempts I enabled
SKIP_SPARE_EN which seems not to work when not using ECC modes.

A bad block scan of a 1GiB chip dropped from 3.9s to 0.2s.

The MTD kernel module tests seem to pass still:

=================================================
mtd_speedtest: MTD device: 4
mtd_speedtest: MTD device size 1068498944, eraseblock size 262144, page size 4096, count of eraseblocks 4076, pages per eraseblock 64, OOB size 224
mtd_test: scanning for bad eraseblocks
mtd_test: block 4072 is bad
mtd_test: block 4073 is bad
mtd_test: block 4074 is bad
mtd_test: block 4075 is bad
mtd_test: scanned 4076 eraseblocks, 4 are bad
mtd_speedtest: testing eraseblock write speed
mtd_speedtest: eraseblock write speed is 11499 KiB/s
mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 15251 KiB/s
mtd_speedtest: testing page write speed
mtd_speedtest: page write speed is 9588 KiB/s
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 15213 KiB/s
mtd_speedtest: testing 2 page write speed
mtd_speedtest: 2 page write speed is 10291 KiB/s
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 15416 KiB/s
mtd_speedtest: Testing erase speed
mtd_speedtest: erase speed is 128000 KiB/s
mtd_speedtest: Testing 2x multi-block erase speed
mtd_speedtest: 2x multi-block erase speed is 333364 KiB/s
mtd_speedtest: Testing 4x multi-block erase speed
mtd_speedtest: 4x multi-block erase speed is 335187 KiB/s
mtd_speedtest: Testing 8x multi-block erase speed
mtd_speedtest: 8x multi-block erase speed is 345061 KiB/s
mtd_speedtest: Testing 16x multi-block erase speed
mtd_speedtest: 16x multi-block erase speed is 344264 KiB/s
mtd_speedtest: Testing 32x multi-block erase speed
mtd_speedtest: 32x multi-block erase speed is 347941 KiB/s
mtd_speedtest: Testing 64x multi-block erase speed
mtd_speedtest: 64x multi-block erase speed is 348522 KiB/s
mtd_speedtest: finished
=================================================

==================================================
mtd_nandbiterrs: MTD device: 3
mtd_nandbiterrs: MTD device size 1048576, eraseblock=262144, page=4096, oob=224
mtd_nandbiterrs: Device uses 1 subpages of 4096 bytes
mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
mtd_nandbiterrs: incremental biterrors test
mtd_nandbiterrs: write_page
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 0 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 0/5
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 1 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 1 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 0/2
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 2 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 2 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 0/0
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 3 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 3 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 1/7
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 4 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 4 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 1/5
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 5 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 5 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 1/2
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 6 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 6 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 1/0
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 7 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 7 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 2/6
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 8 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 8 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 2/5
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 9 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 9 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 2/2
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 10 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 10 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 2/0
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 11 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 11 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 3/7
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 12 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 12 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 3/6
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 13 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 13 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 3/5
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 14 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 14 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 3/2
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 15 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 15 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 3/0
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: Read reported 16 corrected bit errors
mtd_nandbiterrs: verify_page
mtd_nandbiterrs: Successfully corrected 16 bit errors per subpage
mtd_nandbiterrs: Inserted biterror @ 4/2
mtd_nandbiterrs: rewrite page
mtd_nandbiterrs: read_page
mtd_nandbiterrs: error: read failed at 0x0
mtd_nandbiterrs: After 17 biterrors per subpage, read reported error -74
mtd_nandbiterrs: finished successfully.
==================================================

==================================================
mtd_nandbiterrs: MTD device: 3
mtd_nandbiterrs: MTD device size 1048576, eraseblock=262144, page=4096, oob=224
mtd_nandbiterrs: Device uses 1 subpages of 4096 bytes
mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
mtd_nandbiterrs: overwrite biterrors test
mtd_nandbiterrs: write_page
mtd_nandbiterrs: Read reported 1 corrected bit errors
mtd_nandbiterrs: Read reported 2 corrected bit errors
mtd_nandbiterrs: Read reported 3 corrected bit errors
mtd_nandbiterrs: Read reported 4 corrected bit errors
mtd_nandbiterrs: Read reported 5 corrected bit errors
mtd_nandbiterrs: Read reported 8 corrected bit errors
mtd_nandbiterrs: Read reported 10 corrected bit errors
mtd_nandbiterrs: Read reported 12 corrected bit errors
mtd_nandbiterrs: Read reported 14 corrected bit errors
mtd_nandbiterrs: Read reported 21 corrected bit errors
mtd_nandbiterrs: Read reported 28 corrected bit errors
mtd_nandbiterrs: Read reported 32 corrected bit errors
mtd_nandbiterrs: Read reported 40 corrected bit errors
mtd_nandbiterrs: Read reported 48 corrected bit errors
mtd_nandbiterrs: Read reported 56 corrected bit errors
mtd_nandbiterrs: Read reported 64 corrected bit errors
mtd_nandbiterrs: Read reported 72 corrected bit errors
mtd_nandbiterrs: Read reported 80 corrected bit errors
mtd_nandbiterrs: Read reported 88 corrected bit errors
mtd_nandbiterrs: Read reported 96 corrected bit errors
mtd_nandbiterrs: Read reported 104 corrected bit errors
mtd_nandbiterrs: Read reported 112 corrected bit errors
mtd_nandbiterrs: error: read failed at 0x0
mtd_nandbiterrs: Read reported error -74
mtd_nandbiterrs: Bit error histogram (2209 operations total):
mtd_nandbiterrs: Page reads with   0 corrected bit errors: 977
mtd_nandbiterrs: Page reads with   1 corrected bit errors: 92
mtd_nandbiterrs: Page reads with   2 corrected bit errors: 81
mtd_nandbiterrs: Page reads with   3 corrected bit errors: 7
mtd_nandbiterrs: Page reads with   4 corrected bit errors: 4
mtd_nandbiterrs: Page reads with   5 corrected bit errors: 3
mtd_nandbiterrs: Page reads with   6 corrected bit errors: 0
mtd_nandbiterrs: Page reads with   7 corrected bit errors: 0
mtd_nandbiterrs: Page reads with   8 corrected bit errors: 9
mtd_nandbiterrs: Page reads with   9 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  10 corrected bit errors: 42
mtd_nandbiterrs: Page reads with  11 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  12 corrected bit errors: 24
mtd_nandbiterrs: Page reads with  13 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  14 corrected bit errors: 62
mtd_nandbiterrs: Page reads with  15 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  16 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  17 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  18 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  19 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  20 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  21 corrected bit errors: 15
mtd_nandbiterrs: Page reads with  22 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  23 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  24 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  25 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  26 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  27 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  28 corrected bit errors: 75
mtd_nandbiterrs: Page reads with  29 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  30 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  31 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  32 corrected bit errors: 148
mtd_nandbiterrs: Page reads with  33 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  34 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  35 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  36 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  37 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  38 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  39 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  40 corrected bit errors: 74
mtd_nandbiterrs: Page reads with  41 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  42 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  43 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  44 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  45 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  46 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  47 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  48 corrected bit errors: 37
mtd_nandbiterrs: Page reads with  49 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  50 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  51 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  52 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  53 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  54 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  55 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  56 corrected bit errors: 93
mtd_nandbiterrs: Page reads with  57 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  58 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  59 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  60 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  61 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  62 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  63 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  64 corrected bit errors: 23
mtd_nandbiterrs: Page reads with  65 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  66 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  67 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  68 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  69 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  70 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  71 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  72 corrected bit errors: 258
mtd_nandbiterrs: Page reads with  73 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  74 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  75 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  76 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  77 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  78 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  79 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  80 corrected bit errors: 90
mtd_nandbiterrs: Page reads with  81 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  82 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  83 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  84 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  85 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  86 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  87 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  88 corrected bit errors: 14
mtd_nandbiterrs: Page reads with  89 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  90 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  91 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  92 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  93 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  94 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  95 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  96 corrected bit errors: 21
mtd_nandbiterrs: Page reads with  97 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  98 corrected bit errors: 0
mtd_nandbiterrs: Page reads with  99 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 100 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 101 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 102 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 103 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 104 corrected bit errors: 32
mtd_nandbiterrs: Page reads with 105 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 106 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 107 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 108 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 109 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 110 corrected bit errors: 0
mtd_nandbiterrs: Page reads with 111 corrected bit errors: 0
mtd_nandbiterrs: finished successfully.
==================================================

=================================================
mtd_oobtest: MTD device: 3
mtd_oobtest: MTD device size 1048576, eraseblock size 262144, page size 4096, count of eraseblocks 4, pages per eraseblock 64, OOB size 224
mtd_test: scanning for bad eraseblocks
mtd_test: scanned 4 eraseblocks, 0 are bad
mtd_oobtest: test 1 of 5
mtd_oobtest: writing OOBs of whole device
mtd_oobtest: written up to eraseblock 0
mtd_oobtest: written 4 eraseblocks
mtd_oobtest: verifying all eraseblocks
mtd_oobtest: verified up to eraseblock 0
mtd_oobtest: verified 4 eraseblocks
mtd_oobtest: test 2 of 5
mtd_oobtest: writing OOBs of whole device
mtd_oobtest: written up to eraseblock 0
mtd_oobtest: written 4 eraseblocks
mtd_oobtest: verifying all eraseblocks
mtd_oobtest: verified up to eraseblock 0
mtd_oobtest: verified 4 eraseblocks
mtd_oobtest: test 3 of 5
mtd_oobtest: writing OOBs of whole device
mtd_oobtest: written up to eraseblock 0
mtd_oobtest: written 4 eraseblocks
mtd_oobtest: verifying all eraseblocks
mtd_oobtest: verified up to eraseblock 0
mtd_oobtest: verified 4 eraseblocks
mtd_oobtest: test 4 of 5
mtd_oobtest: attempting to start write past end of OOB
mtd_oobtest: an error is expected...
mtd_oobtest: error occurred as expected
mtd_oobtest: attempting to start read past end of OOB
mtd_oobtest: an error is expected...
mtd_oobtest: error occurred as expected
mtd_oobtest: attempting to write past end of device
mtd_oobtest: an error is expected...
mtd_oobtest: error occurred as expected
mtd_oobtest: attempting to read past end of device
mtd_oobtest: an error is expected...
mtd_oobtest: error occurred as expected
mtd_oobtest: attempting to write past end of device
mtd_oobtest: an error is expected...
mtd_oobtest: error occurred as expected
mtd_oobtest: attempting to read past end of device
mtd_oobtest: an error is expected...
mtd_oobtest: error occurred as expected
mtd_oobtest: test 5 of 5
mtd_oobtest: writing OOBs of whole device
mtd_oobtest: written up to eraseblock 0
mtd_oobtest: written up to eraseblock 0
mtd_oobtest: written 3 eraseblocks
mtd_oobtest: verifying all eraseblocks
mtd_oobtest: verified up to eraseblock 0
mtd_oobtest: verified 3 eraseblocks
mtd_oobtest: finished with 0 errors
=================================================

=================================================
mtd_readtest: MTD device: 3
mtd_readtest: MTD device size 1048576, eraseblock size 262144, page size 4096, count of eraseblocks 4, pages per eraseblock 64, OOB size 224
mtd_test: scanning for bad eraseblocks
mtd_test: scanned 4 eraseblocks, 0 are bad
mtd_readtest: testing page read
mtd_readtest: finished
=================================================

=================================================
mtd_subpagetest: MTD device: 3
mtd_subpagetest: MTD device size 1048576, eraseblock size 262144, page size 4096, subpage size 4096, count of eraseblocks 4, pages per eraseblock 64, OOB size 224
mtd_test: scanning for bad eraseblocks
mtd_test: scanned 4 eraseblocks, 0 are bad
mtd_subpagetest: writing whole device
mtd_subpagetest: written up to eraseblock 0
mtd_subpagetest: written 4 eraseblocks
mtd_subpagetest: verifying all eraseblocks
mtd_subpagetest: verified up to eraseblock 0
mtd_subpagetest: verified 4 eraseblocks
mtd_subpagetest: verifying all eraseblocks for 0xff
mtd_subpagetest: verified up to eraseblock 0
mtd_subpagetest: verified 4 eraseblocks
mtd_subpagetest: writing whole device
mtd_subpagetest: written up to eraseblock 0
mtd_subpagetest: written 4 eraseblocks
mtd_subpagetest: verifying all eraseblocks
mtd_subpagetest: verified up to eraseblock 0
mtd_subpagetest: verified 4 eraseblocks
mtd_subpagetest: verifying all eraseblocks for 0xff
mtd_subpagetest: verified up to eraseblock 0
mtd_subpagetest: verified 4 eraseblocks
mtd_subpagetest: finished with 0 errors
=================================================

=================================================
mtd_stresstest: MTD device: 3
mtd_stresstest: MTD device size 1048576, eraseblock size 262144, page size 4096, count of eraseblocks 4, pages per eraseblock 64, OOB size 224
mtd_test: scanning for bad eraseblocks
mtd_test: scanned 4 eraseblocks, 0 are bad
mtd_stresstest: doing operations
mtd_stresstest: 0 operations done
mtd_stresstest: 1024 operations done
mtd_stresstest: 2048 operations done
mtd_stresstest: 3072 operations done
mtd_stresstest: 4096 operations done
mtd_stresstest: 5120 operations done
mtd_stresstest: aborting test due to pending signal!
mtd_stresstest: error -4 occurred
=================================================

--
Stefan

Changes since v1:
- Split controller and NAND chip structure
- Add BCH support
- Allow to select algorithm and strength using device tree
- Improve HW ECC error reporting and use DEC_STATUS_BUF only
- Use SPDX license identifier
- Use per algorithm mtd_ooblayout_ops
- Use setup_data_interface callback for NAND timing configuration

Changes since v2:
- Set clock rate using assigned-clocks
- Use BIT() macro
- Fix and improve timing calculation
- Improve ECC error handling
- Store OOB layout for tag area in Tegra chip structure
- Update/fix bindings
- Use more specific variable names (replace "value")
- Introduce nand-is-boot-medium
- Choose sensible ECC strenght automatically
- Use wait_for_completion_timeout
- Print register dump on completion timeout
- Unify tegra_nand_(read|write)_page in tegra_nand_page_xfer

Changes since v3:
- Implement tegra_nand_(read|write)_raw using DMA
- Implement tegra_nand_(read|write)_oob using DMA
- Name registers according to Tegra 2 Technical Reference Manual (v02p)
- Use wait_for_completion_io_timeout to account for IO
- Get chip select id from device tree reg property
- Clear interrupts and reinit wait queues in case command/DMA times out
- Set default MTD name after nand_set_flash_node
- Move MODULE_DEVICE_TABLE after declaration of tegra_nand_of_match
- Make (rs|bch)_strength static

Lucas Stach (1):
  ARM: dts: tegra: add Tegra20 NAND flash controller node

Stefan Agner (5):
  mtd: rawnand: add Reed-Solomon error correction algorithm
  mtd: rawnand: add an option to specify NAND chip as a boot device
  mtd: rawnand: tegra: add devicetree binding
  mtd: rawnand: add NVIDIA Tegra NAND Flash controller driver
  ARM: dts: tegra: enable NAND flash on Colibri T20

 .../devicetree/bindings/mtd/nand.txt          |    6 +-
 .../bindings/mtd/nvidia-tegra20-nand.txt      |   64 +
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/tegra20-colibri-512.dtsi    |   16 +
 arch/arm/boot/dts/tegra20.dtsi                |   15 +
 drivers/mtd/nand/raw/Kconfig                  |    6 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 drivers/mtd/nand/raw/nand_base.c              |    4 +
 drivers/mtd/nand/raw/tegra_nand.c             | 1248 +++++++++++++++++
 include/linux/mtd/rawnand.h                   |    7 +
 10 files changed, 1373 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
 create mode 100644 drivers/mtd/nand/raw/tegra_nand.c

-- 
2.17.1

