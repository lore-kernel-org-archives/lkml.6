Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbeDPMa3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:30:29 -0400
Received: from foss.arm.com ([217.140.101.70]:58954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753239AbeDPMa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:30:27 -0400
Date: Mon, 16 Apr 2018 13:30:20 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180416123019.GA9341@e107981-ln.cambridge.arm.com>
References: <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
 <939f7943-feec-aaa2-3bd3-59a6618330c0@linaro.org>
 <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
 <20180416093747.GB4244@vireshk-i7>
 <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
 <20180416095006.GC4244@vireshk-i7>
 <b0e7ff16-c947-89a0-6bd9-56ee9a76e7ad@linaro.org>
 <20180416101021.GD4244@vireshk-i7>
 <1c61128a-dea6-b12c-4cd8-ef53a5c8628d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c61128a-dea6-b12c-4cd8-ef53a5c8628d@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 02:10:30PM +0200, Daniel Lezcano wrote:
> On 16/04/2018 12:10, Viresh Kumar wrote:
> > On 16-04-18, 12:03, Daniel Lezcano wrote:
> >> On 16/04/2018 11:50, Viresh Kumar wrote:
> >>> On 16-04-18, 11:45, Daniel Lezcano wrote:
> >>>> Can you elaborate a bit ? I'm not sure to get the point.
> >>>
> >>> Sure. With your current code on Hikey960 (big/LITTLE), you end up
> >>> creating two cooling devices, one for the big cluster and one for
> >>> small cluster. Which is the right thing to do, as we also have two
> >>> cpufreq cooling devices.
> >>>
> >>> But with the change Sudeep is referring to, the helper you used to get
> >>> cluster id will return 0 (SoC id) for all the 8 CPUs. So your code
> >>> will end up creating a single cpuidle cooling device for all the CPUs.
> >>> Which would be wrong.
> >>
> >> Is the semantic of topology_physical_package_id changing ?
> > 
> > That's what I understood from his email.
> > 
> >> I don't
> >> understand the change Sudeep is referring to.
> 
> Actually there is no impact with the change Sudeep is referring to. It
> is for ACPI, we are DT based. Confirmed with Jeremy.
> 
> So AFAICT, it is not a problem.

It is a problem - DT or ACPI alike. Sudeep was referring to the notion
of "cluster" that has no architectural meaning whatsoever and using
topology_physical_package_id() to detect a "cluster" was/is/will always
be the wrong thing to do. The notion of cluster must not appear in the
kernel at all, it has no architectural meaning. I understand you need
to group CPUs but that has to be done in a different way, through
cooling devices, thermal domains or power domains DT/ACPI bindings but
not by using topology masks.

You should be able to figure out this week at OSPM the reasoning behind
what I am saying above.

Cheers,
Lorenzo
