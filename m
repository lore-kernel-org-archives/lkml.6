Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeCENiX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:38:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932954AbeCENiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:38:21 -0500
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH 0/3] indirectly reclaimable memory
Date: Mon, 5 Mar 2018 13:37:39 +0000
Message-ID: <20180305133743.12746-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:ec6d]
X-ClientProxiedBy: VI1PR02CA0076.eurprd02.prod.outlook.com
 (2603:10a6:802:14::47) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59964516-1e67-453c-d152-08d5829e5398
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:aTP5uBtfDvvbkd1N6OuTqZrEWZOSQFKQV1M1Vudv45ro4s+7drd0GLZtuxcohhnpqYFgBtE8s//P+XXWXgDwA0jgZXM3e8to8/BKShPVwHRBUfXldhrnazcn/s6XqT6sfPBjIVFWG3g1YRJ9FkidwtFJurglr871bxF7K8b25S+6r8wefgJA7okR/HC8VHRI2kGo4qs3B3q/8/2p6Sja2MVtIGgTUcP7DhXRFEEfi9kVv0KJYRXGQfJhrNf5KggX;25:aaCjFVQ/fujKJVAKTLODtGApdgSNOECr2CIBzWmbaB1fYwFpbV1pih7EJA/gOuRM/hqQXv5W14ifTfvmlxIo1Tq5Rk4RzPblo6KkcLfAmY3rez4cJwW1rwq1S9uXaM8BPHCyGZJBvzu0uDs1sMHNpMX36NqzCcdT1x3ApmEwNI0JGXUv7p9/g3s7ZdBZOpY8eqYQost6n/1EE6Hu0Y2zUtrSYKBRzPaln7UHSGWpID4BSAjoIPu+96klMzd83dIxCO9o9UXhqNb9zaJD4BiMeiTVgoDr2oe/Cm+L0iQu5Qw4Duu9bkaRwlzr/AsHE/I5KivWksaK1EpXu5l7mJoU9Q==;31:CgxmHuOSr8p7bWrlGPXTiFSCPPq6g7Rz1P9NiOSPmDJHI3bRqVbi8/dk0YHIL9WcsUJLB5PbwrGzcxmWy8Dmk+kJITmQqDtU1SF+PZ3ELsM/gL6Tx3dEW0wtI4iWiqya5H3YpjPtlygONRJmplU1Y0mqTWlfndGCSkYYWbO6xldeI2l6AXgCwo42wBmuGuiOP0ndwFh7vqATgvFNxlSMQjCLK+8iscxwBQ3+a+Vg2l4=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:p+8UNbYt8JUxD+OaPjk3f4D0Wpfp1YK8TnnrDK1mNpka27w67Ps00PGCi+TPGw6yoBB9Dc6n7tJEFSDt7Vc27ji43pNjvlxumn6+zG7F6QAz4nvEGPsK1Z7qiLEfUZpWol5rpAYgvBxn+t/t8enFvnbCj/muFdyFbsBnUjqbbp5IZFP0nyzLhDac/CGCuEuX9iOEVgNrESdCL6KuTpnU/sJ4b3Qf9+NA67y+yEV88Vma9+EMo/cERng0YbvuhZH+ByzbSaVvGzesEEu6gIe2pzgU/XPVNj30s0AIuKb8ggPnTf6TqjuyMJmKi1UdweViQ7tswm18FktSwgjnkZKSBo3Gtfe94yxSoeWbG36ojdr1KD2bepblU/JMHqKWnCx5URKb0DFKDB1va+zOejYW4uhOedSfdXJj3jruKrOq2YwBUGSYq97UbahD3vCjuJa3BQQSKGt2vkvFZg+VtrjkvRnEJYLT2YOWXDZ61Uma9imMa8JcTNFeS4wXkzzGC5NQ;4:b/JluUwRlCB79lytKOwBMGPELdPFh171YFdYQT4i9I6ifAUFgd3Q3MYSsLVBvobom8PAH7eLMmXRcnH8v3mVhnOz38jnxn+Cr3rBj8kBhAhP/oOK0kN6y/Pb2NFujWo7SWX182omaeDCgh5P7IchV3CL26YTQdXXxuriy57yv3M7JWXdaAISft7i6U/3uNVEebwbPAWtdy70HW2N7Euxw+LvRAHXhbKkPR9bxgaq4xW58R4bWMjo6weRWhhNoUdHiQUU0J0Z7T/3r+OjRNo6P/OM1q3BdAJTsmFazyLbnnKgq+ZeUQfcfDTaXUFZ3L4xMHqVnvBm1mphS1ZZoxgVqmJp5o+eo2L45VuNN0/0bQI=
X-Microsoft-Antispam-PRVS: <BL2PR15MB1076EC8D6908D3342C77E06BBEDA0@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(366004)(346002)(376002)(189003)(199004)(8936002)(47776003)(50466002)(1076002)(50226002)(48376002)(7736002)(16526019)(186003)(4326008)(305945005)(8676002)(81156014)(81166006)(2906002)(59450400001)(6506007)(386003)(5660300001)(2351001)(478600001)(36756003)(106356001)(2361001)(6666003)(6916009)(6116002)(6486002)(16586007)(316002)(97736004)(54906003)(52396003)(52116002)(46003)(51416003)(53936002)(6512007)(6306002)(69596002)(105586002)(25786009)(966005)(68736007)(86362001)(53416004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:xj+YJjrGCj/yknixDJLQmy9Qon3PAfSYidGSCpiuv?=
 =?us-ascii?Q?Lce5P4XjqajjUN3lLEs/2mzaTZSnEBOOFtXIcNY4SnBpfWSHbMuckxuTeuun?=
 =?us-ascii?Q?0edt+u5J2TCPKLzS8cdsoB1DJxlofbQhatNLE5VlrKCdQfEQhaCaMZYeQ+HE?=
 =?us-ascii?Q?ANmH2iuxscsy3DTXV/y4uhvkFfVVh6ryV1pmRB0rr7cBF4w33sV3UTsZf/R5?=
 =?us-ascii?Q?cYRBXk3qdJ3EPr9ZqUWj7bxR4FUMaY2StPZ4dfCIZqFkwKMMm/b4kM3sw7ks?=
 =?us-ascii?Q?uKDUs4Fwxxp5iPJgR0+quzxRjLsgmeOPswACeQuEXPVVg+0WbsYbfehLn/OR?=
 =?us-ascii?Q?3avOZJWadpZKgQ9J4Nb14bdYCfdSVvgeaS4tGVLkv1RbKzhWKvNHqI6c1Q6U?=
 =?us-ascii?Q?PP3fMI6ZKUfgpCPG7DnlYYbV3U9FmDId+FWkLaNgre6IAIHSaS+6hcuYt4WP?=
 =?us-ascii?Q?EN8QSPhprSG2beon9nj/IieczDZ/1Fg6esiSPZ12chv2Jvcm30A7nno+RKeR?=
 =?us-ascii?Q?Zae9DtXZNC0giY7V/f5BujlRdXORbJNtYAL4Zf8136RmVNgy2N5JxKuIujSl?=
 =?us-ascii?Q?/qJhrmMU0MFu/iHjjASc9WjLFID6dud+JZnYACi66yjusDd4PKF/J/dFmuJF?=
 =?us-ascii?Q?oGtiRnUTBlYsiX+L9GmEXTS4TlxqYb8MVfZ8CsnvDY7rPBIT2YdfIJyn7xSF?=
 =?us-ascii?Q?AH/574+VzQ53vuJFG1+hfEn32k2X7W18nXii+pnZn1VudVf1gjgqmLcYTvlk?=
 =?us-ascii?Q?0BhOvJo+bpKaKriI+vk6Re1qntoQ5RF3aiNbm8RJhAzxeWL4xxr85x4bftTZ?=
 =?us-ascii?Q?JfwYNrsQXMal+UtVDBb/TWBTwJNz7Agb/uABCFL7MmxAIwgspHSJTRPQ7PwD?=
 =?us-ascii?Q?z4mK6yeFWlPMHKUcrRX3/qKfw6taeJdgRr4Mh9RA4v8nR+sa/67RC4eGJwlU?=
 =?us-ascii?Q?5QtJXqIUAsoBlimo5oPwKLfFkzdtX5HRW5v/jEg+0DIwxH9u5jtdxl1op40h?=
 =?us-ascii?Q?RPB8eiPE9mR8HXsVcZv9hYCrFhOS4YPNeUyun6Y5bLCLjXiR8F6uI6kVzoIc?=
 =?us-ascii?Q?laZRKFO5idjG/El/eaucsoxsfigu5vf9YoiBzW063W3iPJXxclv3nmIdR0yM?=
 =?us-ascii?Q?9KJEiIfFfZ7x3ga4CCmW6lZR2rHMK01YsqjKBNYkb0no9Z/5z/XRm9DIVHBu?=
 =?us-ascii?Q?neCwXwb6Q1t4OBThgQnZdVYzymw/3SelU0oFnYi9U/a3zyDXXoyZP0zn/iL5?=
 =?us-ascii?Q?fKPejaWUnZmbiyZuuI=3D?=
X-Microsoft-Antispam-Message-Info: cbXQLQMQoAQnt9XQ0iaJRSizIIZQ/JVpB71t0ZiBgt8eLl3bxdFERwOcnBJobLld3hEIs01FsHa0lo50bZOmdDjDXMFojG+OrvGoiOtSZL9xjw46/8hT5mH3aPu+G1NnNv0jxvTZFeToUTfcXew2+g4cXaVRa3Nm38I3h+DIsuIS3j4VJ0xQ6nf/7o2R8Feg
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:FBloSVJnuoEErT3S3oyK6cSKLG9kxtSPDR+5drzdvAX06r5EwHiWk406AF5cXsUachx7I7+hgjYZlOTG2OpBcRoO8g3aVzq8ZcTEUvL6Vrlnn1YKOEtmXsYSB5G5IivTMoX/EBWw40pj6DSHttxBA+2zgWAXd7/E8RJTi2G3MlGAGnFqLGrIy7b34ePwlEv4E0W3i8IrvQ1FJVuze4wfLVkgvivWLHy4qdky2+jVgRwcSvLM/9h7E10jqZsiavHPUQUU+UtrB0njpXwreEsajzfvlMnnjvutrh1iPqkcBxOTFt31iqiLQUEMb9vkNaP5xxEDcV9wlh+k3Wr1+e2glJpqqS0fS6XasX6cqzPgKUk=;5:CD+niokbhMAkZfCx1nXCxkFVwmHqzeM2NL18Tkgm1ZLIQ5Q3jY5oUnxg7b4RHnXQLiGZtLA8vH5kQtdPxvHxLVztNDUxF7xplSmhyoisszEm7t9q4+RBbgIr9t73H2tKW/+igHlqfTrj11MSaYkaNzcUcDtOQV5LWH5Ehu/8NmU=;24:PM2aBSMIL5GC0dflANI+7TI6v83n/PBlOK5mKjQ+XG6xhFqQdE6XQpcy01+LmGz24oyZk6u0Dik7u5uqeRoCTdc+rowRhQsJLu6pyxqsULE=;7:RRVm6JhULo0OnMzE0ecxUSs4t7onlL9NRg1dghwNQagANiNVI8YIxXDl+Injlv7j1Lpe9tK61iyf0Z6Q6gD52phWoqkvZyHaOTi57qsUDm1KesTTALYswo7fsdG298Fy4XRlpXrsSrc6xBUZU422LOaL01NGG+NtTz07QO9ECuRxUeRazWPoH/Aj+RGeodfHPS17atPQpw5fKoFDYfbiRAJ3rE5B4AY6fUsYqr4J+fzovvsynA6/iSozrWvXUtzL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:Z9xWhVbb9ustsK2/PGzPwoB3VW4u5PsVg+hHPQHGai9v4meQK8oZ4/Pa3LMCLM/o+/C29NPWNZfp5UZKHYk6Vwh4IPALUcbh0stfmn9ZlsGXEmJAx/6bFM6MX9JkUV7AEgmRsZ3SpCSYBIfcnGe+HEr/jhLAtqzRHNtLo0QhhJs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 13:38:04.6760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59964516-1e67-453c-d152-08d5829e5398
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces the concept of indirectly reclaimable
memory and applies it to fix the issue, when a big number
of dentries with external names can significantly affect
the MemAvailable value.

v2:
1) removed comments specific to unreclaimable slabs
2) splitted into 3 patches

v1:
https://lkml.org/lkml/2018/3/1/961

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com

Roman Gushchin (3):
  mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
  mm: treat indirectly reclaimable memory as available in MemAvailable
  dcache: account external names as indirectly reclaimable memory

 fs/dcache.c            | 29 ++++++++++++++++++++++++-----
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        |  7 +++++++
 mm/vmstat.c            |  1 +
 4 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.14.3
