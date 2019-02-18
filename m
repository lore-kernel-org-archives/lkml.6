Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA77217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550518497;
	bh=zwitRAD/B0dVWx/f4q5L00/dguwGsIDRsIY01/FGXeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qp1B07GrHkt7IIedJaO5EEmkyInwDnsDG07XSEqukJ235nihhd+aj3RZ4xOnGkuSq
	 8GDRsgEGKI0GMn2Cxr/h7UX7ceUO6ww/q/BHox/QUa5H1ubQpFkV0ExbK5b/aVjwLw
	 tSpqgilyjND/4aqg1lJbWaI+uVSYP89t+38jX6Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBRTez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfBRTez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:34:55 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDD32177E;
        Mon, 18 Feb 2019 19:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550518494;
        bh=zwitRAD/B0dVWx/f4q5L00/dguwGsIDRsIY01/FGXeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2XEp7OchkeDm+R+7sesJAyJcbAVpZtuHSpFGXINbTcb5Tko/6xkh9+DOOKO/MDZWt
         H3pGSYetD+9PZZheYpz4vs38hXJcmOQFinSLwWEEV8nlsZaFthFex7KrH+KufjIfHQ
         zND0jT1JEVRmlG9tFU1EipJVZRcrNb8v9TgMZgvw=
Date:   Mon, 18 Feb 2019 14:34:52 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Wolfgang Walter <linux@stwm.de>, Roman Gushchin <guro@fb.com>,
        Spock <dairinin@gmail.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a
 relatively small number of objects"
Message-ID: <20190218193452.GV10616@sasha-vm>
References: <20190218133454.668268457@linuxfoundation.org>
 <20190218133501.533140116@linuxfoundation.org>
 <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:30:44AM -0500, Rik van Riel wrote:
>On Mon, 2019-02-18 at 14:43 +0100, Greg Kroah-Hartman wrote:
>> 4.20-stable review patch.  If anyone has any objections, please let
>> me know.
>>
>> ------------------
>>
>> From: Dave Chinner <dchinner@redhat.com>
>>
>> commit a9a238e83fbb0df31c3b9b67003f8f9d1d1b6c96 upstream.
>>
>> This reverts commit 172b06c32b9497 ("mm: slowly shrink slabs with a
>> relatively small number of objects").
>
>This revert will result in the slab caches of dead
>cgroups with a small number of remaining objects never
>getting reclaimed, which can be a memory leak in some
>configurations.

What's the "right" choice though? we get either leaky cgroups or hanging
xfs.

>But hey, that's your tradeoff to make.

I don't think that any decision was made here, the stable tree simply
follows upstream with regards to fixes and bugs such as these: we remain
"bug compatible" with upstream in these scenarios, there was no decision
made to prefer either bug.

--
Thanks,
Sasha
