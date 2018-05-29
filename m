Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937001AbeE2Q4H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:56:07 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:33230 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935486AbeE2Q4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:56:04 -0400
Subject: Re: [PATCH] cpupower : Fix header name to read idle state name
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, trenn@suse.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s1seetee@linux.vnet.ibm.com, Shuah Khan <shuah@kernel.org>
References: <20180528110303.12860-1-huntbag@linux.vnet.ibm.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <bc47aebe-cfa4-6a33-b503-311e5088f33b@kernel.org>
Date: Tue, 29 May 2018 10:55:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528110303.12860-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 05:03 AM, Abhishek Goel wrote:
> The names of the idle states in the output of cpupower monitor command are
> truncated to 4 characters. On POWER9, this creates ambiguity as the states
> are named "stop0", "stop1", etc.
> 
> root:~# cpupower monitor
>               |Idle_Stats
> PKG |CORE|CPU | snoo | stop | stop | stop | stop | stop | stop
>    0|   0|   0|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  1.90
>    0|   0|   1|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
>    0|   0|   2|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
>    0|   0|   3|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
> 
> This patch modifies the output to print the state name that results in a
> legible output. The names will be printed with atmost 1 padding in left.
> 
> root:~# cpupower monitor
>               | Idle_Stats
>  PKG|CORE| CPU|snooze|stop0L| stop0|stop1L| stop1|stop2L| stop2
>    0|   0|   0|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.72
>    0|   0|   1|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
>    0|   0|   2|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
>    0|   0|   3|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
> 
> This patch does not affect the output for intel.
> Output for intel before applying the patch:
> 
> root:~# cpupower monitor
>     |Idle_Stats
> CPU | POLL | C1-S | C1E- | C3-S | C6-S | C7s- | C8-S | C9-S | C10-
>    0|  0.00|  0.14|  0.39|  0.35|  7.41|  0.00| 17.67|  1.01| 70.03
>    2|  0.00|  0.19|  0.47|  0.10|  6.50|  0.00| 29.66|  2.17| 58.07
>    1|  0.00|  0.11|  0.50|  1.50|  9.11|  0.18| 18.19|  0.40| 66.63
>    3|  0.00|  0.67|  0.42|  0.03|  5.84|  0.00| 12.58|  0.77| 77.14
> 
> Output for intel after applying the patch:
> 
> root:~# cpupower monitor
>     | Idle_Stats
>  CPU| POLL | C1-S | C1E- | C3-S | C6-S | C7s- | C8-S | C9-S | C10-
>    0|  0.03|  0.33|  1.01|  0.27|  3.03|  0.00| 19.18|  0.00| 71.24
>    2|  0.00|  1.58|  0.58|  0.42|  8.55|  0.09| 21.11|  0.99| 63.32
>    1|  0.00|  1.26|  0.88|  0.43|  9.00|  0.02|  7.78|  4.65| 71.91
>    3|  0.00|  0.30|  0.42|  0.06| 13.62|  0.21| 30.29|  0.00| 52.45
> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
> 
> Previous attempt was made by Seeteena Thoufeek. This is the patch list
> link: https://patchwork.kernel.org/project/linux-pm/list/?submitter=
> 172041&state=*&archive=both
> 
>  .../utils/idle_monitor/cpuidle_sysfs.c        | 15 ++++++++
>  .../utils/idle_monitor/cpupower-monitor.c     | 35 +++++++++++--------
>  .../utils/idle_monitor/cpupower-monitor.h     |  9 +++++
>  3 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> index 5b3205f16217..5b8c4956ff9a 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> @@ -126,6 +126,20 @@ void fix_up_intel_idle_driver_name(char *tmp, int num)
>  	}
>  }
>  
> +#ifdef __powerpc__
> +void map_power_idle_state_name(char *tmp)
> +{
> +	if (!strncmp(tmp, "stop0_lite", CSTATE_NAME_LEN))
> +		strcpy(tmp, "stop0L");
> +	else if (!strncmp(tmp, "stop1_lite", CSTATE_NAME_LEN))
> +		strcpy(tmp, "stop1L");
> +	else if (!strncmp(tmp, "stop2_lite", CSTATE_NAME_LEN))
> +		strcpy(tmp, "stop2L");
> +}
> +#else
> +void map_power_idle_state_name(char *tmp) { }
> +#endif
> +
>  static struct cpuidle_monitor *cpuidle_register(void)
>  {
>  	int num;
> @@ -145,6 +159,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
>  		if (tmp == NULL)
>  			continue;
>  
> +		map_power_idle_state_name(tmp);
>  		fix_up_intel_idle_driver_name(tmp, num);
>  		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
>  		free(tmp);
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index 05f953f0f0a0..051da0a7c454 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -70,36 +70,43 @@ void print_n_spaces(int n)
>  		printf(" ");
>  }
>  
> -/* size of s must be at least n + 1 */
> +/*s is filled with left and right spaces
> + *to make its length atleast n+1
> + */
>  int fill_string_with_spaces(char *s, int n)
>  {
> +	char *temp;
>  	int len = strlen(s);
> -	if (len > n)
> +
> +	if (len >= n)
>  		return -1;
> +
> +	temp = malloc(sizeof(char) * (n+1));
>  	for (; len < n; len++)
>  		s[len] = ' ';
>  	s[len] = '\0';
> +	snprintf(temp, n+1, " %s", s);
> +	strcpy(s, temp);
> +	free(temp);
>  	return 0;
>  }
>  
> +#define MAX_COL_WIDTH 6
>  void print_header(int topology_depth)
>  {
>  	int unsigned mon;
>  	int state, need_len;
>  	cstate_t s;
>  	char buf[128] = "";
> -	int percent_width = 4;
>  
>  	fill_string_with_spaces(buf, topology_depth * 5 - 1);
>  	printf("%s|", buf);
>  
>  	for (mon = 0; mon < avail_monitors; mon++) {
> -		need_len = monitors[mon]->hw_states_num * (percent_width + 3)
> +		need_len = monitors[mon]->hw_states_num * (MAX_COL_WIDTH + 1)
>  			- 1;
> -		if (mon != 0) {
> -			printf("|| ");
> -			need_len--;
> -		}
> +		if (mon != 0)
> +			printf("||");
>  		sprintf(buf, "%s", monitors[mon]->name);
>  		fill_string_with_spaces(buf, need_len);
>  		printf("%s", buf);
> @@ -107,23 +114,21 @@ void print_header(int topology_depth)
>  	printf("\n");
>  
>  	if (topology_depth > 2)
> -		printf("PKG |");
> +		printf(" PKG|");
>  	if (topology_depth > 1)
>  		printf("CORE|");
>  	if (topology_depth > 0)
> -		printf("CPU |");
> +		printf(" CPU|");
>  
>  	for (mon = 0; mon < avail_monitors; mon++) {
>  		if (mon != 0)
> -			printf("|| ");
> -		else
> -			printf(" ");
> +			printf("||");
>  		for (state = 0; state < monitors[mon]->hw_states_num; state++) {
>  			if (state != 0)
> -				printf(" | ");
> +				printf("|");
>  			s = monitors[mon]->hw_states[state];
>  			sprintf(buf, "%s", s.name);
> -			fill_string_with_spaces(buf, percent_width);
> +			fill_string_with_spaces(buf, MAX_COL_WIDTH);
>  			printf("%s", buf);
>  		}
>  		printf(" ");
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> index 9e43f3371fbc..2ae50b499e0a 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> @@ -15,7 +15,16 @@
>  
>  #define MONITORS_MAX 20
>  #define MONITOR_NAME_LEN 20
> +
> +/* CSTATE_NAME_LEN is limited by header field width defined
> + * in cpupower-monitor.c. Header field width is defined to be
> + * sum of percent width and two spaces for padding.
> + */
> +#ifdef __powerpc__
> +#define CSTATE_NAME_LEN 7
> +#else
>  #define CSTATE_NAME_LEN 5
> +#endif
>  #define CSTATE_DESC_LEN 60
>  
>  int cpu_count;
> 

Thanks for the patch. Applied to 

git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower
for 4.18-rc1

thanks,
-- Shuah
