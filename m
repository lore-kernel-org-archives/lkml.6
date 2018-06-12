Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 76A73C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363972086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363972086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934728AbeFLQab (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:30:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55104 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933751AbeFLQa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:30:29 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fSmBX-0000mI-FC; Tue, 12 Jun 2018 10:30:20 -0600
To:     Jon Mason <jdmason@kudzu.us>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-4-logang@deltatee.com>
 <CAPoiz9yF1c8ybJzA1ViUkvgxo2=u9ytTn6+kYuKv1HZSsUOuWw@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f64a72ea-d7c8-5dd4-f41c-b43cb4af337f@deltatee.com>
Date:   Tue, 12 Jun 2018 10:30:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPoiz9yF1c8ybJzA1ViUkvgxo2=u9ytTn6+kYuKv1HZSsUOuWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shuah@kernel.org, Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, allenbh@gmail.com, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, jdmason@kudzu.us
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/8] NTB: Fix the default port and peer numbers for legacy
 drivers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/18 09:59 AM, Jon Mason wrote:
>> Patches for ntb_pingpong and ntb_perf follow (which are broken
>> otherwise) to support hardware that doesn't have port numbers. This is
>> important not only to not break support with existing drivers but for
>> the cross link topology which, due to its perfect symmetry, cannot
>> assign unique port numbers to each side.
> 
> This is a very long way of saying "no clients are checking the error
> codes, so removing them". :)

Well, clients not checking the error code made this harder to debug for
sure, but removing the error code is a side effect and not what is
happening here (in fact someone should probably still go back and add
error checking because these functions can still return errors but
that's not really something I have time to do). After the next couple
patches, the clients will use this change to detect that there are no
port numbers and handle things similarly to the way they did before they
were broken by the multiport changes.

> I think the history and references to follow-on patches are not
> necessary in the commit message and belong more in a 0/X.

This is the opposite of what I've ever heard before. Having a commit
message that explains what led up to this commit is a good thing and
allows people debugging in the future to better understand the decisions
made. People debugging commits will never find the 0/X cover letter
which is just intended to introduce the series to reviewers and describe
changes if the series is posted multiple times.

> This is more of a feature than a bug fix.  Can you break this (and the
> pingpong and perf changes caused by this) off into a separate series,
> as I'll want to apply this to the ntb-next and not bugfixes branch?

No this is not a feature request. This is fixing a regression that broke
previously working code in the only sensible way I can come up with. If
you have a better way to fix this, I'd be glad to hear it. But this
should *not* be treated as a feature request.

Logan
