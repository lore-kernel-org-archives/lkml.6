Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033081AbeE2BjO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:39:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936769AbeE2BjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:39:10 -0400
From: Stewart Smith <stewart@linux.ibm.com>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : Add Description for cpuidle state
In-Reply-To: <20180528173442.100642-1-huntbag@linux.vnet.ibm.com>
References: <20180528173442.100642-1-huntbag@linux.vnet.ibm.com>
Date: Tue, 29 May 2018 11:39:01 +1000
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18052901-0044-0000-0000-0000041EBA68
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009096; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000263; SDB=6.01039142; UDB=6.00531818; IPR=6.00818269;
 MB=3.00021349; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 01:39:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052901-0045-0000-0000-00000850DDAF
Message-Id: <87d0xf6y16.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290017
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abhishek Goel <huntbag@linux.vnet.ibm.com> writes:
> @@ -215,7 +216,7 @@ static inline void add_powernv_state(int index, const char *name,
>  				     u64 psscr_val, u64 psscr_mask)
>  {
>  	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
> -	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
> +	strlcpy(powernv_states[index].desc, desc, CPUIDLE_DESC_LEN);

We should still fall back to using name in the event of desc being null,
as not all firmware will expose the descriptions.

> @@ -311,6 +313,11 @@ static int powernv_add_idle_states(void)
>  		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
>  		goto out;
>  	}
> +	if (of_property_read_string_array(power_mgt,
> +		"ibm,cpu-idle-state-descs", descs, dt_idle_states) < 0) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-descs in DT\n");
> +		goto out;
> +	}

I don't think pr_warn is appropriate here, as for all current released
firmware we don't have that property. I think perhaps just silently
continuing on is okay, as we have to keep compatibility with that firmware.

> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -17,7 +17,7 @@
>
>  #define CPUIDLE_STATE_MAX	10
>  #define CPUIDLE_NAME_LEN	16
> -#define CPUIDLE_DESC_LEN	32
> +#define CPUIDLE_DESC_LEN	60

Do we really get that long?

-- 
Stewart Smith
OPAL Architect, IBM.
