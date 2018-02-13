Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965628AbeBMTtT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:49:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965551AbeBMTtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:49:17 -0500
Subject: Re: [PATCH 2/2] powerpc/pseries: Declare optional dummy function for
 find_and_online_cpu_nid
To: Guenter Roeck <linux@roeck-us.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
 <1518474848-3158-2-git-send-email-linux@roeck-us.net>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 11:49:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518474848-3158-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021319-0020-0000-0000-00000D70A211
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008528; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000253; SDB=6.00989255; UDB=6.00502300; IPR=6.00768610;
 BA=6.00005827; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019537; XFM=3.00000015;
 UTC=2018-02-13 19:49:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021319-0021-0000-0000-00006018A835
Message-Id: <943e73c6-cadb-cf9e-9c7f-a7b687e7177a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 02:34 PM, Guenter Roeck wrote:
> Commit e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with
> memoryless nodes") adds an unconditional call to find_and_online_cpu_nid(),
> which is only declared if CONFIG_PPC_SPLPAR is enabled. This results in
> the following build error if this is not the case.
> 
> arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_online_cpu':
> arch/powerpc/platforms/pseries/hotplug-cpu.c:369:
> 			undefined reference to `.find_and_online_cpu_nid'
> 
> Follow the guideline provided by similar functions and provide a dummy
> function if CONFIG_PPC_SPLPAR is not enabled. This also moves the external
> function declaration into an include file where it should be.
> 
> Fixes: e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with ...")
> Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Nathan already sent a patch on the 9th for this issue to the list.

-Tyrel

> ---
>  arch/powerpc/include/asm/topology.h          | 5 +++++
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 --
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 88187c285c70..52815982436f 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -82,6 +82,7 @@ static inline int numa_update_cpu_topology(bool cpus_locked)
>  extern int start_topology_update(void);
>  extern int stop_topology_update(void);
>  extern int prrn_is_enabled(void);
> +extern int find_and_online_cpu_nid(int cpu);
>  #else
>  static inline int start_topology_update(void)
>  {
> @@ -95,6 +96,10 @@ static inline int prrn_is_enabled(void)
>  {
>  	return 0;
>  }
> +static inline int find_and_online_cpu_nid(int cpu)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
> 
>  #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_NEED_MULTIPLE_NODES)
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index dceb51454d8d..f5c6a8cd2926 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -340,8 +340,6 @@ static void pseries_remove_processor(struct device_node *np)
>  	cpu_maps_update_done();
>  }
> 
> -extern int find_and_online_cpu_nid(int cpu);
> -
>  static int dlpar_online_cpu(struct device_node *dn)
>  {
>  	int rc = 0;
> 
