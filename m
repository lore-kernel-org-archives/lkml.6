Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A6FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578F8216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MpKBvyQ5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MpKBvyQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578F8216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeHURHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:07:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:07:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2CF5461474; Tue, 21 Aug 2018 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534859261;
        bh=Fnc23PoxZMiv56ZKhJKK1tOqcdTPCEs1Iru4rFPU9qI=;
        h=From:Subject:To:Date:From;
        b=MpKBvyQ5camamXpPRNHh8iyHM8OIv9lVQLp1HdAH2FMQQqui3NtnVUwjSpoOQYhae
         JedQ+wcHApuo2zQTMRhP5ivG/lQQZdC7b9txC6ewYIsrXWWMTrGVRldnq719+ysyU9
         4OVEMhvSWS52ge4k+UaBOggYavQh/lu8caLD68UQ=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10CB0612E0;
        Tue, 21 Aug 2018 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534859261;
        bh=Fnc23PoxZMiv56ZKhJKK1tOqcdTPCEs1Iru4rFPU9qI=;
        h=From:Subject:To:Date:From;
        b=MpKBvyQ5camamXpPRNHh8iyHM8OIv9lVQLp1HdAH2FMQQqui3NtnVUwjSpoOQYhae
         JedQ+wcHApuo2zQTMRhP5ivG/lQQZdC7b9txC6ewYIsrXWWMTrGVRldnq719+ysyU9
         4OVEMhvSWS52ge4k+UaBOggYavQh/lu8caLD68UQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10CB0612E0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
Subject: Query on skip_onerr field in struct cpuhp_step
To:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <c228c495-63fa-5af9-32ff-355410d78cc8@codeaurora.org>
Date:   Tue, 21 Aug 2018 19:17:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is about one of field in struct cpuhp_step

* @skip_onerr: Do not invoke the functions on error rollback
  *              Will go away once the notifiers are gone
         bool                    skip_onerr;

Why this field was introduced, can anyone explain the history behind ? 
As i don't see it being set from anywhere

If it is specifically was dependent on notifiers, did we missed to 
remove it as the notifiers are gone or the usecase still there?
And If it is still valid, in what scenario i would not want my callback 
to be called in rollback path?

Thanks,
Mukesh
