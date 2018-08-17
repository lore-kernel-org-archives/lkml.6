Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553ECC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E42D218F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a5S9vvZg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a5S9vvZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E42D218F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeHQNMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:12:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQNMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:12:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F0AE61D9E; Fri, 17 Aug 2018 10:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534500571;
        bh=HESva+i8hTMsA71rValiHcyU/plElvpU4Qe8o4k0oCY=;
        h=To:From:Subject:Date:From;
        b=a5S9vvZgYntw3gSxCQNWxi+0Re8G8Om/gvLch9MHu4PeDRV00BjQpHs7+heH7HFao
         iVp0vD5Chj3xhaxUoZP7Y7Ui9lpg710SiTHiFcS/LRSI6vWPsaZEyBJI2mZgAcM8cW
         Is3e3BAwJvkLg5dInH9w9QLA+VlR7+C3pgFjxwfk=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33FE561C74;
        Fri, 17 Aug 2018 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534500571;
        bh=HESva+i8hTMsA71rValiHcyU/plElvpU4Qe8o4k0oCY=;
        h=To:From:Subject:Date:From;
        b=a5S9vvZgYntw3gSxCQNWxi+0Re8G8Om/gvLch9MHu4PeDRV00BjQpHs7+heH7HFao
         iVp0vD5Chj3xhaxUoZP7Y7Ui9lpg710SiTHiFcS/LRSI6vWPsaZEyBJI2mZgAcM8cW
         Is3e3BAwJvkLg5dInH9w9QLA+VlR7+C3pgFjxwfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33FE561C74
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
To:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Subject: Query on shrink list
Message-ID: <301a5546-d326-d78e-3be6-41b5a6a08c0e@codeaurora.org>
Date:   Fri, 17 Aug 2018 15:39:22 +0530
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

Hi Al Viro,

Is there is reason we have kept data->found++, if the dentry already 
there in shrink list ?

static enum d_walk_ret select_collect(
...
         if (dentry->d_flags & DCACHE_SHRINK_LIST) {
                 data->found++;
         } else {
   ..

If the dentry is already there on shrink list, does it not mean that 
data->found is already non-zero ?
Can't we just go out from here directly?


Regards,
Mukesh

