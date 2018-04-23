Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeDWQok (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:44:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932206AbeDWQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:44:24 -0400
Date: Mon, 23 Apr 2018 18:44:19 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To: "Theodore Ts'o" <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG, PATCH] random: sleep in irq context
In-Reply-To: <alpine.LFD.2.21.1804231518060.1767@schleppi>
References: <alpine.LFD.2.21.1804231518060.1767@schleppi>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina?=
 =?ISO-8859-15?Q?_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 18042316-0040-0000-0000-000004320DC5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042316-0041-0000-0000-000026363518
Message-Id: <alpine.LFD.2.21.1804231843240.1675@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, Sebastian Ott wrote:
> From 9d29e0c92efaf94277bc178782523283958ae8c8 Mon Sep 17 00:00:00 2001
> From: Sebastian Ott <sebott@linux.ibm.com>
> Date: Mon, 23 Apr 2018 14:59:20 +0200
> Subject: [PATCH] random: don't sleep during allocations in irq context
> 
> Since numa_crng_init() can be called from irq context let's
> use __GFP_ATOMIC for allocations.
> 
> Fixes: 8ef35c866f88 ("random: set up the NUMA crng instances...")
> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
> ---
>  drivers/char/random.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 3cd3aae24d6d..e96ea2bf7241 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -791,14 +791,14 @@ static void crng_initialize(struct crng_state *crng)
>  #ifdef CONFIG_NUMA
>  static void numa_crng_init(void)
>  {
> +	gfp_t gfp_flags = GFP_KERNEL | __GFP_NOFAIL | __GFP_ATOMIC;

I should have removed GFP_KERNEL here...
