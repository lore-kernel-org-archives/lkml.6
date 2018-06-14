Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A621CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D449208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0utCaxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D449208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754743AbeFNHhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:37:15 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37331 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754603AbeFNHhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:37:09 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21-v6so7861641lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kehnpMGy3E3ogmw+u7+0RyfzSfKms7KfjmEy0y3zZU=;
        b=V0utCaxZ+9A5m/beAwl8mN4CZEBGLhjsqKzVdZbBtwJipWRLtnlEzEmQSsm9g/VijI
         cwceVUlOnnB1FTyG0c+EgnrJTwHU0zlsH+GCSiGA6NAJU8AeQQ9h8m/hyaXf32DHPlDj
         TVoSp87f/hmLnv3Ot8tevo9vGNHe8/hgwpzy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7kehnpMGy3E3ogmw+u7+0RyfzSfKms7KfjmEy0y3zZU=;
        b=M6LphsWJiJaR+Mgr3g0fUaFTmnYjaFLus5SPaCEI85n9vwliO9RzrpQ3rhmpIjNkPG
         amJvO+I2xpJzOU5dIpeKxmsKN6cU+lVfVyrGZ5QmUhfozpMMEQeJ59eY8YhEFu9kuVgn
         kUpmvAHukn53BpsUAvhJw6wghgq6uX3WdOXJEhrfRu9kwn49dPX97Jxbn2XHqGRKdovJ
         +x5Akt0PIrAUduaigWP9ckkYbcLSvsCPyQ1BdeYdGQfqda/oo/tXKbX8dfolXv4yePK8
         l8fC4aiFlh1wOkKpYTzBOrS1dcBdTzH8HctOjNUm9pcc8/E0Hae/joKt7ROwUbEu5m3s
         VUjg==
X-Gm-Message-State: APt69E0IauFZlv7KURMLDWx+DohXhDHQBGjFT07S/OhzVL+4jFqdDQVh
        9fk0NyLveaL+y+RDv/GeH6asog==
X-Google-Smtp-Source: ADUXVKLNBUUGjRH7gDb1xCTNGqxI3ecLU39X1CkXMSI9VTITFHpQ3Ke4IkqsEJRDO/OiqdS0su2MfA==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr886661ljj.143.1528961828407;
        Thu, 14 Jun 2018 00:37:08 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a195-v6sm957597lfe.44.2018.06.14.00.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 00:37:07 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 0/6] net: ethernet: ti: cpsw: add MQPRIO and CBS Qdisc offload
Date:   Thu, 14 Jun 2018 10:36:44 +0300
Message-Id: <20180614073650.29659-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds MQPRIO and CBS Qdisc offload for TI cpsw driver.
It potentially can be used in audio video bridging (AVB) and time
sensitive networking (TSN).

Patchset was tested on AM572x EVM and BBB boards. Last patch from this
series adds detailed description of configuration with examples. For
consistency reasons, in role of talker and listener, tools from
patchset "TSN: Add qdisc based config interface for CBS" were used and
can be seen here: https://www.spinics.net/lists/netdev/msg460869.html

Based on net-next/master

v2..v1:
 - changed name cpsw.txt on ti-cpsw.txt
 - changed name cpsw_set_tc() on cpsw_set_mqprio()

Ivan Khoronzhuk (6):
  net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
  net: ethernet: ti: cpdma: fit rated channels in backward order
  net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
  net: ethernet: ti: cpsw: add CBS Qdisc offload
  net: ethernet: ti: cpsw: restore shaper configuration while down/up
  Documentation: networking: cpsw: add MQPRIO & CBS offload examples

 Documentation/networking/ti-cpsw.txt    | 540 ++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw.c          | 364 +++++++++++++++-
 drivers/net/ethernet/ti/davinci_cpdma.c |  31 +-
 3 files changed, 913 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/networking/ti-cpsw.txt

-- 
2.17.1

