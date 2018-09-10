Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578CB2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+RmnBEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578CB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeIJUOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbeIJUOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:14:35 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57BE20833;
        Mon, 10 Sep 2018 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536592801;
        bh=PkUN8EYqOyZaXc+3Zo6lFo2hbVZDEfpsa3dWuKlwbeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+RmnBEBwjDye2GC8RTcFrD/RLF5O7nhy96jycXUsH2c8HNttHFJXV5DlWXefJqWN
         6+UBprwFEnJm5MMUKvIecm5eHqcwej+BXwSgEOPNlra1s96Ch5lnnrKgU85jjClsuz
         kAy6e1beJZQEmciovQqCtQVV0XCt8bMTlLSVSJvA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4F657141FFC; Mon, 10 Sep 2018 12:19:58 -0300 (-03)
Date:   Mon, 10 Sep 2018 12:19:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 77/77] perf tests: Fix record+probe_libc_inet_pton.sh
 without ping's debuginfo
Message-ID: <20180910151958.GN5147@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
 <20180905220440.20256-78-acme@kernel.org>
 <62359230-cfb2-676d-6baf-93282ee99afc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62359230-cfb2-676d-6baf-93282ee99afc@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 07, 2018 at 02:09:13PM +0200, Thomas-Mich Richter escreveu:
> On 09/06/2018 12:04 AM, Arnaldo Carvalho de Melo wrote:
> > rpm -e iputils-debuginfo
> 
> I have done the same on my s390 this morning:
> 
> [root@p23lp27 perf]# ./perf test ping
> 60: probe libc's inet_pton & backtrace it with ping       : Ok
> [root@p23lp27 perf]# rpm -e iputils-debuginfo
> [root@p23lp27 perf]# ./perf test ping
> 60: probe libc's inet_pton & backtrace it with ping       : Ok
> [root@p23lp27 perf]#
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks for testing!

- Arnaldo
