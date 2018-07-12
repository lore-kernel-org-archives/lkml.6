Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BBC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FEC208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="c32j5rFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FEC208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeGLMij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:38:39 -0400
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:47264
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbeGLMij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aw1YDct8js5lzCK8UxF36FbiRYLMsBPpsONktDN4bg=;
 b=c32j5rFdFZn6RlblXHttOMxzkr9kY+SDgDCm8OdOd4SBmJ/3HhWBIlUNPPjnELAsYmj48IKRGDGf6O/V0p3yTy1cZNVSjP6aiIWDx3FTNcaKaxkn8sRb/luOmBx2GV+YFR3QX7tOeQzP+n2/xubtBXjeNobvDiLYcpAxk4PASQo=
Received: from localhost (5.166.131.251) by
 DM6PR07MB4380.namprd07.prod.outlook.com (2603:10b6:5:bf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 12:29:10 +0000
Date:   Thu, 12 Jul 2018 15:29:01 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Chris Metcalf <cmetcalf@mellanox.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>, Tejun Heo <tj@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Francis Giraldeau <francis.giraldeau@gmail.com>,
        Sunil Goutham <sgoutham@cavium.com>, linux-mm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 00/13] support "task_isolation" mode
Message-ID: <20180712122901.GA5049@yury-thinkpad>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [5.166.131.251]
X-ClientProxiedBy: AM5PR0701CA0001.eurprd07.prod.outlook.com
 (2603:10a6:203:51::11) To DM6PR07MB4380.namprd07.prod.outlook.com
 (2603:10b6:5:bf::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 293dd0a1-637b-4c44-c2f6-08d5e7f31230
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4380;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;3:ihFtJabyMlvQ3MPfXaVZcezJh8Q2Qo6HKjdJrez2M1Tmkt+wVGqTb5DotAPYxaoJGc0ZUSEpunozXworXSQ2iDYtL5BduMZOV96mo2y49q+pv6Obxcu3LqGqX5BF6ZYG5uGzYFkrOFrQzMcP4G7aWrjklGwYkS7Mcwa2e8phKB+NCqgHLWQTAX//48RX6IBskjEavoe+s8KgsbVaAnii3zuNPeZq5h63Z3X7hzXBoSMyBIQVzFE51YjT3V/+SM5A;25:HzxaGorVSu/Y+Z/MRDQZEIUloTIed9P0X56NLglPkqhVaxzZGj1u+yrVzOAzgeSH+2Kq0GEqF8UP2SJX/FatHF1MK80wcj8Y5NFBysUOSCdr/2MaUMk5r1ZnDft3WUCdrAGJiRv8RC/oG3g89oyf3/GQw9CaUHbkAT2xZTgSDfqZ0rIWKyhKH9ZbL+aKWQ7XGjbLcejExTDEbcKSTdFD+kvFQwbpYH2aSBSbXvYNc+prhE7R6q2vQS3mnqjOggVNxi9feWHEI19zFCxRfN9xGcB/jxYKA0xLvE5SiMcXtD4SXtduznAGZfqA/3zRzZBimPZLZVO5ENFCbhq3uLgrIw==;31:xPCR42H1C9dlxK13YS8jpXqT4l5wDRJ99vmsIK6jndV0nEgnXkU5tY45QunLwEDtVHNT1fXP76ZF9FKC929UKRPmw55aWKdAmaXLoNDZhlIPFqos4Z0a4mGKV3msiE0X5SIa7JupvH86yvlOfhxR07us7NHX3FKgOcTaczG8XU6/XsmrZiYUTddEHyVAJJmkFpxhnqTjQeCOL+gIRZOnEwSpCFpQZPNbC7avsxbgndI=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4380:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;20:G5wWebtqxKkfHgafhN8ORZA6hCQOsUgQQadI2WEFlJqD9Lr55QJmzfk8AJF1S1jVawXo3B+srN/mhTBx3TzTyi/Pefpl7SDJjrfBLd9wBdplcFr0fmmlazEJpyUK0Wf0MtJgRylyizN5cNPxzyf5pNIujHWr1SJ3nqEalkx4I9ev/LliiWwO/Y2vZY8VS7xTNFcNr1jPewOVtQLzmwbzX/XNrew7WmOFDzsIxNJ+hztMpUKklABtoiiJAwFDZBcXfWPXLZV99icSwpMqWIf4QjnQOuLXlLZ5VU0CTfk+6QBPItLAUxdfRtT6Y+635zFj+lGn81mTNFCdrqisXi6Ja7rDgwo0gnXd2YJU5VURkhZvK7sD3yUrb9iTZiLh2u9iMU6mLIZ0qu6kOo18hRheCqb9D0LlrldCsg8XY95YI9ZAPwFDsCZXBva/UiG81cZLc3lxCw089WQFejeZjV8bXs86QyZ1/aIKECPrPJJtnvtEMtNgb9bNrvJTIaoG/QqheDdsTJdg9bHOwuCUMbUVNxfDjEKrRleQSb3Ue8BLrPSjnNQJBgkwz26JHbM/E5yrW+2XaWlHpX3Yu+vcxijDFNrGXf8tKYMldjCSBP9GwDE=;4:e88raoADKZiCwSRCnHLeUudNNQvfuQz+O6+7a78tPm5xSz+KqMQ5mwwr2WGfFJ5h7DXao2zvwFhR0LFD0eeapnFUxm/sIunCLV7xn/RnlWF/j88e/JEWcS72neFGIcP6CVxC3bGBuIpXmB7Uuneahfv7ToTA3JbeXHC+X766P7IpajFJc00do8j+BBLnY5Jh6V/gTEnBfHU7twkg+8d1Wb2491cvkdk4GquZsfNMY1RcRO1jwT3+w+b5urLjQ9GRps0LGhL/4TaBI8YSoIOpsA==
X-Microsoft-Antispam-PRVS: <DM6PR07MB43801DA1A470D04C92C43AF3E3590@DM6PR07MB4380.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4380;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4380;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(199004)(189003)(39060400002)(33656002)(53546011)(53936002)(105586002)(386003)(7736002)(6246003)(97736004)(106356001)(33896004)(6496006)(6116002)(76506005)(7416002)(76176011)(4326008)(52116002)(305945005)(11346002)(956004)(476003)(446003)(3846002)(42882007)(478600001)(25786009)(72206003)(486006)(8936002)(9686003)(26005)(68736007)(50466002)(5660300001)(71446004)(186003)(16526019)(16586007)(81166006)(14444005)(575784001)(81156014)(6666003)(316002)(6486002)(6916009)(47776003)(229853002)(23726003)(66066001)(58126008)(1076002)(54906003)(8676002)(2906002)(33716001)(18370500001)(21314002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4380;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4380;23:goa9Um12b7ehgrunnXNXZorpHAbLj1u11Ag4Rcxgy?=
 =?us-ascii?Q?KA+lrF84y8f/+1Ci5bCUSpKEs5CKNn9YzwGIuJ2w5CwYuZNcvg87gQZ3/Ign?=
 =?us-ascii?Q?b5rOfEN7cR4Vj8CiJittWTf+4XyQO+TeQvji8nyqUPimYVzbWgqa1l2oPqPY?=
 =?us-ascii?Q?77VrHFmncz60r10l66UCmJ0op4GulDb7xO2Ctt2rRLURwhxvn8372V41pgop?=
 =?us-ascii?Q?yjCnsdnjeFu9QuZ5dGaUh0O4KlDyPqWFwTnQhexEOJiwW/PhjwYQ/XzHTpSj?=
 =?us-ascii?Q?tV4IDuTHlLBeqcgSvbhCsJlLfaNoSQMbh9lr2Ss/CFh77NSXZ4esiJ7/Njyl?=
 =?us-ascii?Q?95awhgNbXyp5wVu8eqVy9i/OyjLQq50f2bm2hkcq60Qt/InmewaGkX66cxzg?=
 =?us-ascii?Q?jZthqTcs4+792ngAfnr/XFR7j6MhR7CULBDcPB8P02GwwRJc+dP+QVk18PJt?=
 =?us-ascii?Q?G0Xmh1rj6vs++3bo6815uTjEfUN2f3a6V1eBNbuKnEhMHhgGH5im4g7X7tl3?=
 =?us-ascii?Q?c6hahmDrHR87Y/+VZipHTQppprI0gGhfTvhlf7IpaZus5Ntyiv0axUDCoU/9?=
 =?us-ascii?Q?NlNjy14Al5F+gbQsk917+WmtPWA4rN01Jzz/MhAy/lW0lcpfc+Y97iEUTn5o?=
 =?us-ascii?Q?xIgw5nMEi5thg8wPFtHgQo3XzcnYQ+/F5quuRTRtALI5dZDyxWf+yz3tIqyc?=
 =?us-ascii?Q?I2TZ2WTi/UWosK9RfzP4WRIREDGZMhQvNIjDToORlld9OYnoOXkG3lhp/Cwx?=
 =?us-ascii?Q?bPunLRaidj+eKbZYEdwl0GNWmpuaQi01Mg8/b9GQC6yX+bt4XjxLwfgmHB9G?=
 =?us-ascii?Q?nobfSZAizFrhDi3DReMutZRQGmFUAD11MLzZHSUQtij5NdyTLnb3SIe4RJyh?=
 =?us-ascii?Q?sVrFin4+/Wu5C6Xa/OjtqQfMR6Y+zEvbG+bvIhXSsTG7Ga+XBRB/EGbPQ9u9?=
 =?us-ascii?Q?OA0q0EDTVRyCK9jfNpyphCHOdlX4pqZQN3hVjczosxFLpgDDXy3PKauizZQl?=
 =?us-ascii?Q?Nsj3M05Wps7b/nmfvFR0QQ3qo28+8PbTf8p3KPheO5SzNa/sYx0uoT5bxPgq?=
 =?us-ascii?Q?hHLtdbwbDG1YPyJqL8p9Ze8KAJ35a31ihYp+JpuGXWfCr6WxwrEGI20e2Zkc?=
 =?us-ascii?Q?ogIJ690fSA2xk5xeehkJEABSRZzGI9PPNv7DCqfyZgrCKj+4GuSzs/7EPydH?=
 =?us-ascii?Q?qKvxMxpOMlcaoLTRxLHbNLMR1VSYVok+02np1EijFAOO18oTlfaNZBkrPaL+?=
 =?us-ascii?Q?/GLR3VxxUMUZQfZqqbVm7PoLC3MWbY4Xwdb73P6LjGa2zfiYxcp6TstNFttr?=
 =?us-ascii?Q?aJN6jrS006uUZRadctF4u4Kj0kWKriPcw6Fzmvacdc/XcLkmtDeJOG4kUWrT?=
 =?us-ascii?Q?dJVzZWYJ5LoPiSJHM4JyWVXry6FLbS5uAPwI05ncJBspzWMoMhuE1wewj0iF?=
 =?us-ascii?Q?+f0mTT9n7dUAzAd8lQUaqUXhh1D4KgmkpEvgH3scNrWT4F+Lhr14uam87z/g?=
 =?us-ascii?Q?mEEBajwYGrQU3N138jy3NWFe55ZABHLwW7ryqKWDOiAOhWSyDeaSvMNSYyC+?=
 =?us-ascii?Q?nAZEB2nuWOSYAvI0nfhARenS9yw9++C1B7PJoFo1vG1bphhpwKuuw2HBwYqH?=
 =?us-ascii?Q?ZF7amCl77DogLDGO9nH8w=3D=3D?=
X-Microsoft-Antispam-Message-Info: YDSQYr/T2aBt8JJ06hilAx3FMx1yWTG5c5PwAxdBqjYR5pmE3sjDnQP+8sJw1/+WR0Qad+uJXKKjXHd8TpRW2RW9HmbTwZxOcRhwwMrwOUsix7pOcQLeE2DqTYgSRw28/Yqbg0FO88Ouay974ZuI9xeJgBgMaFzXsCTnrL8z4VY4RMNK7kxqeihDr8HfyANFiY2R2c89Rn6PCLzGkHGI9xM+VuhtKCQMsR6zoBhRfpXvyDGd+qTVslMeReQy/wMJy60QoSfVH3q1hhe7S9vrfFYD3hFPK0vQjgv8hp4R3RwADPP+DPzcmpHb9yykv2LBpt9EXWi9AuD81kwHEbUf9AgIVqsC+U5pJSVpdxgbooU=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;6:0GtFLErSZU1l5c6v2NY2NAzUvP0JvtYIeaAqeho72+2wb2U64cjh0UU68Js0JScEIUQf/6Xx2W6TqLALPTmZs+t1rG48aIQk7K6XLVozHuK0Hg2Hw9+P+botAjI4JqIwyMt1knyLaOKOCGcfJQadGOvbuRgm3pHEDta0NE5aELWZ2Pgw+P49xAbWigBAiEddwprVYxA6i2cXRm9H41Z22VFhWVDAADXgFtuOmoTYVwaxK295QTSyXD/kinX+fsBijCeQ4U0XcT4wH0GsXXKncVRxk9UHvuY2E1t9AF4nrH+up5UxneOeVRPeuWdgUFz6oyr5qdKZrNJJ8CYPse8u6M2DQFY7DmhfyWl/+aBNasdgfqaWiomY7j1lZbPPsjkIbD2lcyrU0zc/P+NED/X0grtnyPBKWIj7mdcVHgEqyFgd4UoV4TNOrRqkPR4OZuurkX0U299EJUqNCA5lfC/bTQ==;5:KCV7QKDuUUwBnN35OpQ9rmV0Z90OM+c6vcpa9US+WOuajCgxOPijV85EYrhDHK76mwyOGjADrIbaCTlDEbifL0klDR3Pt144hJ2RUTQ6inKfVgLENnEb1hb8HdrRkU5duPPZ1z4ghJmo3Usr3bdvcFm+zHAURa8i+LDM2jzP8jM=;24:iTLWG66EM2RqVD5O9oCt7AXdgjIp8gsRGkr6PLSK91qYIyfkUTlugJmSfmoaejymNdLGx8FwxEARMxJesI6U/zk5HhkMY5ArnToIX5LIgf8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4380;7:7l2D8NniF/Ql53LpK81SRwryImekrhSCesBTcnxwJBIy1zTY6sL8AOLiIN4ITTjhB1AMAZ7VeA+HIL1wtQ3lXG3J1bhX0IKZGZDgq3SxsJzWIdKSooHAcNDwupies9UUukfZPsGtONbIsLI/i/LOU86QGk2pivlvW3AkXLOlzKLNVrPaFenYOKtRw+SCL8ajKeXnVlTspxGpVSRFtLA25jR5LjrIoNtL2Lg0PWcA8uuL7h4PJSor3B6DmO8C7IlE
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 12:29:10.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 293dd0a1-637b-4c44-c2f6-08d5e7f31230
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4380
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2017 at 01:04:39PM -0400, Chris Metcalf wrote:
> Here, finally, is a new spin of the task isolation work (v16), with
> changes based on the issues that were raised at last year's Linux
> Plumbers Conference and in the email discussion that followed.

Hi Chris,

There's another possible way to break task isolation, by net subsystem.
See patch below.

Yury


From 8025e9330bf06ce146d4ba96833aad6eafe24759 Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@caviumnetworks.com>
Date: Sun, 8 Jul 2018 00:40:46 +0300
Subject: [PATCH] net: don't let user assign task isolation CPUs for RPS

Receive Packet Steering (RPS) subsystem distributes network traffic
handling to CPUs defined by user in
/sys/class/net/<dev>/queues/rx-<n>/rps_cpus.

If rps_cpus intersects with task_isolation_map, RPS may break task
isolation by assigning RPS work to CPU that runs isolated task.

In this patch user-provided rps_cpus map filtered to avoid that.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/isolation.h |  2 ++
 net/core/net-sysfs.c      | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/isolation.h b/include/linux/isolation.h
index f467545ad37d..b7f0a9085b13 100644
--- a/include/linux/isolation.h
+++ b/include/linux/isolation.h
@@ -14,6 +14,8 @@ struct task_struct;
 
 #ifdef CONFIG_TASK_ISOLATION
 
+extern cpumask_var_t task_isolation_map;
+
 /**
  * task_isolation_request() - prctl hook to request task isolation
  * @flags:	Flags from <linux/prctl.h> PR_TASK_ISOLATION_xxx.
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 927a6dcbad96..18e576893984 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -11,6 +11,7 @@
 
 #include <linux/capability.h>
 #include <linux/kernel.h>
+#include <linux/isolation.h>
 #include <linux/netdevice.h>
 #include <net/switchdev.h>
 #include <linux/if_arp.h>
@@ -727,6 +728,18 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 		return err;
 	}
 
+#ifdef CONFIG_TASK_ISOLATION
+	if (cpumask_intersects(mask, task_isolation_map)) {
+		char tmp[256];
+
+		pr_warn("RPS is not allowed on CPUs allocated for isolated tasks\n");
+
+		cpumask_andnot(mask, mask, task_isolation_map);
+		cpumap_print_to_pagebuf(1, tmp, mask);
+		pr_warn("RPS CPUs list is reduced to: %s\n", tmp);
+	}
+#endif
+
 	map = kzalloc(max_t(unsigned int,
 			    RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
 		      GFP_KERNEL);
-- 
2.17.1

