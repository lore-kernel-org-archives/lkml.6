Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F392075D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfA3Xxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:53:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62952 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA3Xx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:53:27 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 90021f72662eca40; Thu, 31 Jan 2019 00:53:24 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Donghee Han <dh.han@samsung.com>,
        Sangkyu Kim <skwith.kim@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Use struct kobj_attribute instead of struct global_attr
Date:   Thu, 31 Jan 2019 00:52:18 +0100
Message-ID: <4097835.HudsOOQepo@aspire.rjw.lan>
In-Reply-To: <3a0a3ec5b36380deb59797f7189dbd0548828cf8.1548400979.git.viresh.kumar@linaro.org>
References: <3a0a3ec5b36380deb59797f7189dbd0548828cf8.1548400979.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 25, 2019 8:23:07 AM CET Viresh Kumar wrote:
> The cpufreq_global_kobject is created using kobject_create_and_add()
> helper, which assigns the kobj_type as dynamic_kobj_ktype and show/store
> routines are set to kobj_attr_show() and kobj_attr_store().
> 
> These routines pass struct kobj_attribute as an argument to the
> show/store callbacks. But all the cpufreq files created using the
> cpufreq_global_kobject expect the argument to be of type struct
> attribute. Things work fine currently as no one accesses the "attr"
> argument. We may not see issues even if the argument is used, as struct
> kobj_attribute has struct attribute as its first element and so they
> will both get same address.
> 
> But this is logically incorrect and we should rather use struct
> kobj_attribute instead of struct global_attr in the cpufreq core and
> drivers and the show/store callbacks should take struct kobj_attribute
> as argument instead.
> 
> This bug is caught using CFI CLANG builds in android kernel which
> catches mismatch in function prototypes for such callbacks.
> 
> Reported-by: Donghee Han <dh.han@samsung.com>
> Reported-by: Sangkyu Kim <skwith.kim@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c      |  6 +++---
>  drivers/cpufreq/intel_pstate.c | 23 ++++++++++++-----------
>  include/linux/cpufreq.h        | 12 ++----------
>  3 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..ef0e33e21b98 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -545,13 +545,13 @@ EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
>   *                          SYSFS INTERFACE                          *
>   *********************************************************************/
>  static ssize_t show_boost(struct kobject *kobj,
> -				 struct attribute *attr, char *buf)
> +			  struct kobj_attribute *attr, char *buf)
>  {
>  	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
>  }
>  
> -static ssize_t store_boost(struct kobject *kobj, struct attribute *attr,
> -				  const char *buf, size_t count)
> +static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
> +			   const char *buf, size_t count)
>  {
>  	int ret, enable;
>  
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index dd66decf2087..5ab6a4fe93aa 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -895,7 +895,7 @@ static void intel_pstate_update_policies(void)
>  /************************** sysfs begin ************************/
>  #define show_one(file_name, object)					\
>  	static ssize_t show_##file_name					\
> -	(struct kobject *kobj, struct attribute *attr, char *buf)	\
> +	(struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
>  	{								\
>  		return sprintf(buf, "%u\n", global.object);		\
>  	}
> @@ -904,7 +904,7 @@ static ssize_t intel_pstate_show_status(char *buf);
>  static int intel_pstate_update_status(const char *buf, size_t size);
>  
>  static ssize_t show_status(struct kobject *kobj,
> -			   struct attribute *attr, char *buf)
> +			   struct kobj_attribute *attr, char *buf)
>  {
>  	ssize_t ret;
>  
> @@ -915,7 +915,7 @@ static ssize_t show_status(struct kobject *kobj,
>  	return ret;
>  }
>  
> -static ssize_t store_status(struct kobject *a, struct attribute *b,
> +static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
>  			    const char *buf, size_t count)
>  {
>  	char *p = memchr(buf, '\n', count);
> @@ -929,7 +929,7 @@ static ssize_t store_status(struct kobject *a, struct attribute *b,
>  }
>  
>  static ssize_t show_turbo_pct(struct kobject *kobj,
> -				struct attribute *attr, char *buf)
> +				struct kobj_attribute *attr, char *buf)
>  {
>  	struct cpudata *cpu;
>  	int total, no_turbo, turbo_pct;
> @@ -955,7 +955,7 @@ static ssize_t show_turbo_pct(struct kobject *kobj,
>  }
>  
>  static ssize_t show_num_pstates(struct kobject *kobj,
> -				struct attribute *attr, char *buf)
> +				struct kobj_attribute *attr, char *buf)
>  {
>  	struct cpudata *cpu;
>  	int total;
> @@ -976,7 +976,7 @@ static ssize_t show_num_pstates(struct kobject *kobj,
>  }
>  
>  static ssize_t show_no_turbo(struct kobject *kobj,
> -			     struct attribute *attr, char *buf)
> +			     struct kobj_attribute *attr, char *buf)
>  {
>  	ssize_t ret;
>  
> @@ -998,7 +998,7 @@ static ssize_t show_no_turbo(struct kobject *kobj,
>  	return ret;
>  }
>  
> -static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
> +static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
>  			      const char *buf, size_t count)
>  {
>  	unsigned int input;
> @@ -1045,7 +1045,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
>  	return count;
>  }
>  
> -static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
> +static ssize_t store_max_perf_pct(struct kobject *a, struct kobj_attribute *b,
>  				  const char *buf, size_t count)
>  {
>  	unsigned int input;
> @@ -1075,7 +1075,7 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
>  	return count;
>  }
>  
> -static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
> +static ssize_t store_min_perf_pct(struct kobject *a, struct kobj_attribute *b,
>  				  const char *buf, size_t count)
>  {
>  	unsigned int input;
> @@ -1107,12 +1107,13 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
>  }
>  
>  static ssize_t show_hwp_dynamic_boost(struct kobject *kobj,
> -				struct attribute *attr, char *buf)
> +				struct kobj_attribute *attr, char *buf)
>  {
>  	return sprintf(buf, "%u\n", hwp_boost);
>  }
>  
> -static ssize_t store_hwp_dynamic_boost(struct kobject *a, struct attribute *b,
> +static ssize_t store_hwp_dynamic_boost(struct kobject *a,
> +				       struct kobj_attribute *b,
>  				       const char *buf, size_t count)
>  {
>  	unsigned int input;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index c86d6d8bdfed..0b427d5df0fe 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -254,20 +254,12 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
>  static struct freq_attr _name =			\
>  __ATTR(_name, 0200, NULL, store_##_name)
>  
> -struct global_attr {
> -	struct attribute attr;
> -	ssize_t (*show)(struct kobject *kobj,
> -			struct attribute *attr, char *buf);
> -	ssize_t (*store)(struct kobject *a, struct attribute *b,
> -			 const char *c, size_t count);
> -};
> -
>  #define define_one_global_ro(_name)		\
> -static struct global_attr _name =		\
> +static struct kobj_attribute _name =		\
>  __ATTR(_name, 0444, show_##_name, NULL)
>  
>  #define define_one_global_rw(_name)		\
> -static struct global_attr _name =		\
> +static struct kobj_attribute _name =		\
>  __ATTR(_name, 0644, show_##_name, store_##_name)
>  
>  
> 

Applied, thanks!


