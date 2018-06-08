Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7HsDGR+5Gls6RQAAmS7hNA
	; Fri, 08 Jun 2018 17:13:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A663E608B8; Fri,  8 Jun 2018 17:13:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="urCv+zs0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 28F4660590;
	Fri,  8 Jun 2018 17:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28F4660590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeFHRNE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:13:04 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:19846 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeFHRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:13:01 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w58HCbWC008555;
        Sat, 9 Jun 2018 02:12:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w58HCbWC008555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528477958;
        bh=8V68o2aoXYaRMPIgzw9KVaMEFZ0hcDpbz1gesv8uClA=;
        h=From:To:Cc:Subject:Date:From;
        b=urCv+zs0MQDhAi/GnOifExwMv9iPDPkqxDtFlWdO0m0YeDyUGulgovrCCZpCI3Jjv
         65EF5sx2xo3Yj9obJhdbpOZ8ShjEozHPxHvhHg1Evz86wRk1jE2KktZgOn7xZ6NZYo
         IBdOh5AgqULOA91csu/vQpfJflYAo+94yarp+DBzPl8xfIpunZ7omPA2mhw1B0Oncr
         MQPp3WmQSiOdpDpG02GzdFVTlTZGUNmw+RrI0eSUEDRT2bT1xvHHJ4j3uFx9bqm/O4
         qqU8LdbKuOTT2X+2DqY6X8nOi9BCN+OTZ5jXTqCRYUc7qnqKfNE/jqCBXgoWTxU5zj
         mFdSKPpWD3dgA==
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 0/3] net: bpfilter: clean-up build rules
Date: Sat,  9 Jun 2018 02:12:07 +0900
Message-Id: <1528477930-7342-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I am unhappy with ugly hacks in this Makefile.
(I could understand what is the hand-crafted .bpfilter_umh.o.cmd
used for.)

Moreover, CONFIG_OUTPUT_FORMAT is causing build errors
because it is defined only for x86.

As far as I understood, what is happening here is
to embed the 'bpfilter_umh' as a blob.
Instead, we can use '.incbin' to include it into a *.S file.

Also, let's stop (ab)using host-program rules.

Only build test is done.



Masahiro Yamada (3):
  bpfilter: add bpfilter_umh to .gitignore
  bpfilter: include bpfilter_umh in assembly instead of using objcopy
  bpfilter: do not (ab)use host-program build rule

 net/bpfilter/.gitignore                 |  1 +
 net/bpfilter/Makefile                   | 30 ++++++++++++------------------
 net/bpfilter/bpfilter_kern.c            | 11 +++++------
 net/bpfilter/{main.c => bpfilter_umh.c} |  0
 net/bpfilter/bpfilter_umh_blob.S        |  7 +++++++
 5 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 net/bpfilter/.gitignore
 rename net/bpfilter/{main.c => bpfilter_umh.c} (100%)
 create mode 100644 net/bpfilter/bpfilter_umh_blob.S

-- 
2.7.4
