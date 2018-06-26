Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D3EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F026822
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DNWhG6SA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DNWhG6SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6F026822
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934001AbeFZJrT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:47:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932963AbeFZJrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:47:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E83A760274; Tue, 26 Jun 2018 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530006436;
        bh=OHgGGnpQo0r9tRs769deeVIWPAj896d+HvkDsOUp+So=;
        h=Date:From:To:Cc:Subject:From;
        b=DNWhG6SAfur7V+/TQzX9/ZwD5i+oQPvO6LtO7MU9oBotZOpb5vAM7Amvc6yDHIvJI
         7SqVKSVqY5Zc3ZSKOZAhcww098i+W6ngya4PvrbYBnNqk1JZ+jezZg/CpZK5VJznbc
         Gc3EtMcp5mtE5iFcK6jnfkMv8Oabq0Y1JdwhYxQY=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90362600ED;
        Tue, 26 Jun 2018 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530006436;
        bh=OHgGGnpQo0r9tRs769deeVIWPAj896d+HvkDsOUp+So=;
        h=Date:From:To:Cc:Subject:From;
        b=DNWhG6SAfur7V+/TQzX9/ZwD5i+oQPvO6LtO7MU9oBotZOpb5vAM7Amvc6yDHIvJI
         7SqVKSVqY5Zc3ZSKOZAhcww098i+W6ngya4PvrbYBnNqk1JZ+jezZg/CpZK5VJznbc
         Gc3EtMcp5mtE5iFcK6jnfkMv8Oabq0Y1JdwhYxQY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90362600ED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 26 Jun 2018 15:17:12 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Question about wakeup granularity calculation in
 wakeup_preempt_entity()
Message-ID: <20180626094712.GF9208@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I have a question about wakeup granularity calculation while checking
if the waking fair task can preempt the current running fair task.

static unsigned long
wakeup_gran(struct sched_entity *curr, struct sched_entity *se)
{
	unsigned long gran = sysctl_sched_wakeup_granularity;

	/*
	 * Since its curr running now, convert the gran from real-time
	 * to virtual-time in his units.
	 *
	 * By using 'se' instead of 'curr' we penalize light tasks, so
	 * they get preempted easier. That is, if 'se' < 'curr' then
	 * the resulting gran will be larger, therefore penalizing the
	 * lighter, if otoh 'se' > 'curr' then the resulting gran will
	 * be smaller, again penalizing the lighter task.
	 *
	 * This is especially important for buddies when the leftmost
	 * task is higher priority than the buddy.
	 */
	return calc_delta_fair(gran, se);
}

The above comment says that the wakeup granularity will be larger when
'se' < 'curr'. But we completely ignore the weight of the curr and
scale the wakeup granularity solely based on the weight of the waking
task i.e se. 

For example, when curr is nice:0 and se is nice:0, the wakeup granularity
is unchanged. However when curr is nice:-15 and se is nice:-15, the
granularity becomes 3% of its original value and favour the waking task.

The git history around these functions revealed that there was once a
sched feature called ASYM_GRAN with which we can control the granularity
scaling wrt curr or se. However if we scale granularity wrt curr, then
preemption becomes difficult for a higher waking up task. 

Is there any reason why we don't want to take both curr and se into account?

scaled_granularity = granularity * (W(curr)/W(se))

I don't have any particular usecase that actually shows a regression. I
spotted this behavior in traces where a lower or default prio task that
is riding on the wakeup bonus is preempting a higher prio task which started
just running. Setting sched_wakeup_granularity to a value higher than the
wakeup bouns may prevent this, but that would make things difficult for
a normal prio tasks preempting a lower prio running task.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

