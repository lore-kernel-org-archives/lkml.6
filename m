Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5680208E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HrQD6qSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5680208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933679AbeGFRaH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:30:07 -0400
Received: from mail.efficios.com ([167.114.142.138]:36414 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932840AbeGFRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:30:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8CC121ABA0C;
        Fri,  6 Jul 2018 13:30:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id TwnR58Thcy5D; Fri,  6 Jul 2018 13:30:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 291FE1ABA09;
        Fri,  6 Jul 2018 13:30:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 291FE1ABA09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530898205;
        bh=sGTjVLhKs7UlysWjuGubEtVrN//e5SMQvM3qf14Jffs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HrQD6qSV+HzEMvb0cVMWupAZm9quctTKyl/9mDSVpROCIJn6mPW+uPg4r2nIIb1gN
         TsLW/Kqfe5Bp5Nd9Fkv7Wfb7N1gDA64foSVRci0vl9V4c0gV5yR/vzgoLh100nmX8K
         02tUwH2gIdURWN/LFGEWCkPILYaDWTozVuB5SSsp8DWNuVRpYb6qxe0T+L6bm8SM0U
         5j8r/PHARTOT6NouauOvqU+l/bgomKMo5qB/qpnnu6Weka6dy+IsaMjSG/H2szUNPK
         I3s4gAwdOn/2Q3MrBjV9CUuz6CykiTv6IvkEMAW3REbdFcIeYMbq+xWVnot3mfuMya
         Y+8B/GgjMvSWg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id p3hMfVCZ1s-g; Fri,  6 Jul 2018 13:30:04 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E63371ABA02;
        Fri,  6 Jul 2018 13:30:04 -0400 (EDT)
Date:   Fri, 6 Jul 2018 13:30:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <208280844.1302.1530898204811.JavaMail.zimbra@efficios.com>
Subject: arm32: Missing __get_user for u64 user type
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Index: iQAX6uI6aXc4dMCNkBwMyYDTCRPEzQ==
Thread-Topic: arm32: Missing __get_user for u64 user type
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The restartable sequence code needs a __get_user for u64 types.
arm32. Although a get_user() is implemented, the architecture
lacks support for 8 bytes __get_user().

Do you guys recommend extending __get_user_err() to do two
__get_user_asm_word() to read it through a temporary union,
or do you have other approaches in mind ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
