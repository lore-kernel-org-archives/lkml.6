Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99FBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8828F21A5C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBcICzch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8828F21A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934593AbeGFSoz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:44:55 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:44898 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934312AbeGFSow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:44:52 -0400
Received: by mail-lj1-f171.google.com with SMTP id q127-v6so9222405ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N0eKhjxGXlNHSSQaIiE+XtGD3cnwh6zOvzfQqbTGD6w=;
        b=PBcICzchdcvCWEvKZZdmN+mfIu+KWDIAr1Yq4xBYnS2djpe9r19WprGOxLt4cOaIzu
         GqaCaJ07F56z6y1aGd2TUXoh/l49x2IfRZY8aD87Xt/worHHCzJ3FpDMyzhyFpYgMkaV
         ITB63my0Znh7U8261Ne4fu7rKwcyJLDySLoTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N0eKhjxGXlNHSSQaIiE+XtGD3cnwh6zOvzfQqbTGD6w=;
        b=XG88XgmFPj5o8BS1Wmt9eo7Qy7LiDC3W5yefyk7vQvpOjvqsdvQJI85uQWTtP/i7eE
         3rLKXibqFqH+p0E8Ab9TSsXgHse/HEBa9WwnURlY6bKoCyBiBS+AV/bacTBjn0lfHhNW
         abRyOER7VFXtmwhVDP0rMDNmh3zIcE4u/Pbyst/5M5mjorCh0qKUgwPN+iyGcfbuLCW+
         cE3ncgHRdTMQ2YCK2YXnujLkwlE0OLw2bHbeEb6SlQjkvTNbKIdKsS1kYO/nHvwdFy/a
         itnCzOMo3BTuuSWvjfmNtAWlV2HQ1AIIk9cSRsvNUGS98hB+AkwqqnRDejfk4doGCRSF
         M+EA==
X-Gm-Message-State: APt69E1mWB/Sh2lPQw5XHRyb0So1qSRA8ZQv3pl0tHsjQz4+cShK50ao
        U+fJNr5EPDES/1ViVZu9dJqUVw==
X-Google-Smtp-Source: AAOMgpedeF3IuaYCW5wwV+sFFLS/y7VMpy5sWsS+nNu7UaL4RuV1PPavli8BdEQr5RgacFMWc1GUTA==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr6994905lji.11.1530902690705;
        Fri, 06 Jul 2018 11:44:50 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h65-v6sm2312063lfb.22.2018.07.06.11.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 11:44:50 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 0/2] allow PTP 224.0.0.107 to be timestamped
Date:   Fri,  6 Jul 2018 21:44:43 +0300
Message-Id: <20180706184445.29111-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows packets with 224.0.0.107 mcas address for PTP packets to be timestamped.
Only for cpsw version > v1.15.

Ivan Khoronzhuk (2):
  net: ethernet: ti: cpsw: use BIT macro
  net: ethernet: ti: cpsw: allow PTP 224.0.0.107 to be timestamped

 drivers/net/ethernet/ti/cpsw.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

-- 
2.17.1

