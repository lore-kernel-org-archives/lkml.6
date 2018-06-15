Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6EBE3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EB02086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="DIC1IiTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EB02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbeFOGci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:32:38 -0400
Received: from mail-db5eur01on0062.outbound.protection.outlook.com ([104.47.2.62]:63744
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755767AbeFOGcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IBFe+ETHfIYtij6RG0dLOE9+VnpdMFc6+wKHUWWt2g=;
 b=DIC1IiTXUqSccG4rVdFzuORYKz3/NO3wquQIIIuVpCBqbfmJpvYlPlh3VgcmRx9fXR2hqFFoYJzWgJ2r66hGqvjlleoFi7cOJ9YrdlW+kFU2/QZvez+sNPXdIgP3+etDxU+sbKLtfS85lLcP470Z6etDjX24MjxvB64Ro6E2q0M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 AM6PR0302MB3205.eurprd03.prod.outlook.com (2603:10a6:209:16::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.14; Fri, 15 Jun
 2018 06:32:29 +0000
Subject: Re: [PATCH v4 5/9] xen/gntdev: Allow mappings for DMA buffers
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180615062753.9229-1-andr2000@gmail.com>
 <20180615062753.9229-6-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <e892748a-c268-9622-e568-4c361366bce1@epam.com>
Date:   Fri, 15 Jun 2018 09:32:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615062753.9229-6-andr2000@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------F4451C5F6BC93CF3F350F4FA"
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM0PR06CA0067.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::44) To AM6PR0302MB3205.eurprd03.prod.outlook.com
 (2603:10a6:209:16::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c56714-2756-4591-41fc-08d5d289c50a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:AM6PR0302MB3205;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0302MB3205;3:En9DCidGcpVlYMG9R33iuYQJQZxXyMRy3Up1QzHG/SSE6tUvtXTrgIX+RkA5K3D1ou0qBZ1PFzbooC7UAVHI5MmRVlJk7fsi+z35q5DXoe0wYXKfZI/S0lJaPtKl2vrm5jcE6xHfYegnjdgxbm706BdrBEAOb+r9sWXyxHsuKN6LG9wXbqbC7AfwK4mW2tcd4qvbAz4zJ5CwkyMOMBBlix+IjxFefYY4AKagULB/QAFfI6T5Zfx++x90Zv+COtr2;25:or2HVbCmdrwCUTbjo6G91VD5t69hMqxXiEwIuBLifckkLAksoWcXp6+z6kXn/JelEYikP/2qPZ7W/e1qc9HnLJZarCy63Pj3S67u75HDXVR5wnOekmG/pXJmqaYbUj/umiJ/BEAzxvYDUJQFzmsldA/m+XbMoc5Eob82ztdnF9hD8Jw+yY77tBpmEDpppfFHxHRFk90/d8ylt7Ew1zeOt0S0US1n78aBYQvtmE1Ylnz/w6e5O+JdHbYjygOfAIAsBDI8iyzCebc12Sq/bYHlaQp/UdgeOy3PDA+Hhw5Zovi/zd1TFuQO2UooG++Duy2Ot52DaNBZQKGnIbyEPRH7OA==;31:Qh/V1KitT03HydIXiyLgGtld62geVmm98WCMuneq33kzHC4b9J5m5niiR8a96yMLU9ejLVrU9108fcKHD5lSp3LG9aEXhQIFO76VTpThfo43bLB23CVPvrdTVbb2ItbQfvZsNx9UWi1pjvJQbPQ75Fb/+Ag6X542JwAODEi5hnerY+Ep173efHHj29cLyijFrLO0A6dDLBooRgywqRredmwiNl1mvD3nlfWEi+tYOCs=
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3205:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0302MB3205;20:q0FameMOiBzBRet5MGSREkOZNjKYSKRRyNybWEbAnOmW3GrMFCuZaNBRPr23ulxunhH/hSGkRfd6pODNe87sZv0njIhOMN8m1Bs0CyTVWpHSjpWiWLccK6fLunS7zKc5ur5n6a4lWQ1cCPLhePBK+NeLcP73xZY2xOugJcCD0tQT9AMe/m+tHqTy+T9YbgI+ZvG9+PtMtLvZ+oZoSGkMC0wEevQhvv89BjVn3PlBl6jzt2HejzdX72A14Jv+zciRi7acb2BG7DW80yt1khr6fu1ovaShA/o6DfR79otfikMtw7uLgr0ekhUI9PpsOwi2MK1bpF05HQjq2NiYA2hq3uvidBqS4ELhHhQpYFVU6okREMjm/Etp7H9RpJo8xHP6J1Vy4rCZD7q56GxhUEsks2CTwnHDGmH98eq3nnu2iLQOjRGFLEiObWg91bs2UYQVjCsxi58X1VcFYEFXOrHpNaSDxyjmcUPlTxHE70XLqIrI5QsvEQtzXjoEp5G+ww9x;4:SeBgSR3k72Gk0+dVzBcYU4BLcNG9SWNJ5tT0vt2G2nUjoT0/vz1e2N1QCmbZWCDpoo5B4hp8UWADfW4727pD02XNelT/qmwTKvRRW4z76NE8QfUm1y9tRSJlvTaD1q9H2C8rioCKC0FRkg67ajzjSmwfgVtgpcrDnD/wWsPYjcMyJLGIat4VFON3HOoIYKP0IyWIwM/7EBy+dDSGkjTnpeIjp5T0kT7M6zyWN3wwbpE8CBM4r78EGclTXfQ7frYhokvFA8BCfs2LDbXEM0jPnjVHJYbWVtjDZzDYZoZ9GHQ68L0s5gQcGHqNP4ab5cgleqDtmL08YTTbJZCcQ+Sjq1XDBfVoc1XfsgH1Ek6awpkDlfukCwWaxacif8xW0PJi
X-Microsoft-Antispam-PRVS: <AM6PR0302MB32057D1E5ADE22F6BE2C1773E77C0@AM6PR0302MB3205.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403)(84791874153150)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR0302MB3205;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0302MB3205;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(376002)(39380400002)(346002)(39860400002)(199004)(189003)(25786009)(53936002)(16576012)(39060400002)(966005)(6246003)(486006)(229853002)(7736002)(97736004)(4326008)(6486002)(64126003)(476003)(305945005)(446003)(956004)(11346002)(72206003)(58126008)(8936002)(77096007)(16586007)(37036004)(2616005)(6116002)(53546011)(66066001)(26005)(65806001)(65956001)(478600001)(16526019)(80792005)(186003)(3846002)(316002)(55236004)(36756003)(68736007)(4610100001)(270700001)(568964002)(65826007)(386003)(84326002)(6306002)(76176011)(31686004)(86362001)(31696002)(6666003)(81156014)(7416002)(2476003)(106356001)(5890100001)(105586002)(5660300001)(52116002)(81166006)(2906002)(33964004)(59450400001)(8676002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0302MB3205;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0302MB3205;23:wfqPaaesNMbcrqLg/PqnWzROgI2Ye1gk5BlBDrN?=
 =?us-ascii?Q?n9Q+8uLfdrz+y7/9wm4VorVRrPr91CSL7jEx+maJIAbBpSqf5rYh27YFcGDc?=
 =?us-ascii?Q?AujhhKVIAje0GKb7kil4ck7OC4QJqttF8tGX9+YNJ/IHuy+QAEr69k5tCCCB?=
 =?us-ascii?Q?PeISzzPzpOnL7WfnEjQ34OU63HPIudeIBtmCEBzvDK7D0vUDMDU4SH8SRaY1?=
 =?us-ascii?Q?7z1uf1RNUPMRGrkx9t+uohnzrivBrirA9zgCJwC6XvpRUXTSe3Z8e7jaD+wB?=
 =?us-ascii?Q?AwzNP4sio3U8r7r3dWMsXvMbiTJfXmOX+trrXcg3WL56EIorDRwmfCNGcSEH?=
 =?us-ascii?Q?7vjzDCJUJjZssV8RNhKFcidgFijliQRUWTAhCgULn2rgTgofoWLV3LnhH8y0?=
 =?us-ascii?Q?9cmjSA2RpDj9qlsnW4/lgXoeTCKZg+8xyQGJkr7JdA44VVzl4ksry+P/3+aj?=
 =?us-ascii?Q?qdGnfR7+0dr2o18myK1aQ5u2TXFaTSzxWrXkmYSENPGefRurXbBYoJXjxUlh?=
 =?us-ascii?Q?rcm/Qy33mYY7i1ioPUw8RK52/nLbVdgo57PQKrtxPE4kizsWAcWW9CKey9/4?=
 =?us-ascii?Q?OvVWkYs62+Ux7pdpnqbZCDqFU/Nc/GVDM9AOvxGP8AdS8zSEbDPMUvE12gqw?=
 =?us-ascii?Q?RVVsQUozckaS4tA86FeEROnClrqhDUHRb4FKwWwJskchZmIGKurNwU5rpLeW?=
 =?us-ascii?Q?5O7QE22RYzoFO0CELMAbsdb2LNGdyAMbpwEl/is0T9FfLGyfL6E/eMFkK074?=
 =?us-ascii?Q?RXn/33ZNdul9RPBeonfAEbDXiVSBCeA+J/GX6SghNLPU3L7ncdAYssc+LH6J?=
 =?us-ascii?Q?Gkdk/q+XrRAKF2cM+c/Wkucsys+74QhivPNCiR5PPt47gQXcB7COzaXfaT34?=
 =?us-ascii?Q?gdHl5eIijwUZNpJR/MtdrCAT7B4FDB6MakoAcesL+x8Z2nWnACMbY32oAdVC?=
 =?us-ascii?Q?u+EctoNxW7BT9MqDC5gcGj3dEwYDAv7rzK3lIHVkYbnNimBbWQ591A4aQgz+?=
 =?us-ascii?Q?y1g+Yj3E9LS8o+w+M4yGmnR+V2bgRp9CmOmAgQEaoKTMW+zCAQmIKM+gdxSw?=
 =?us-ascii?Q?jtiSt/yrAcyvz1sBh7iyAb1gdDZxRqPz4aZ1Qcnmr5eX9Vwfu6Os2aJEkE1R?=
 =?us-ascii?Q?RxNRLSEz22w2dGhfR7eRInx91FOiRtyKKurlOW7hgCkwew+FLUR/NK6hPcoj?=
 =?us-ascii?Q?Zo/jSNK1WsrIjBvb1fCE34oj1KBV/134IhGQGL3wmy86VnTJlw4q88kIdQ64?=
 =?us-ascii?Q?19EdeTx9Y+2Y4XJcW92r9V7PvqJLJUuZDHzkdmxQNSNIMBaHwn5x2mZMJA67?=
 =?us-ascii?Q?zuyuPyUzZQoOa0ujKzB8SkOV2MnojE7KvycdsGNnWx2wDHzafmaqrNXoSk1m?=
 =?us-ascii?Q?4A9QEE7KmqW19TM3cxwHW++IdMsb9KoSZcvGEHgv9PjA/cpdMfUVygHcL2rq?=
 =?us-ascii?Q?sQqlpyRYSzaYMj5nla9Hy+27L8gtmX07YJWqIUANRbJegXa+lZbQfXVOLXCg?=
 =?us-ascii?Q?pT0RC+Eqt0yCvTD8tYmHkdLXHeTPEHJT22hnCchJt8xsuf23PLPTajnLnyP4?=
 =?us-ascii?Q?4iz/o5eN8OzU5k50yzgDVDlsa7aIHvpGaBOtB3sltKwWoU0tEB4Avons/Th/?=
 =?us-ascii?Q?I0LPLW2z1Syy4kPPJoet7cypmj5Pc9CWpkApuIgoJPqYMsylOy3TywVn+5mI?=
 =?us-ascii?Q?4W5mO?=
X-Microsoft-Antispam-Message-Info: ZQIQB4M6aLMjVXYDAD8iXRt4EsTrFHP1dZElWGGwZ2TVR57x4r00j4PR6JeMHvxtCOu/w/9tFoITQAjf+8NjFIFT7YJjK00NA5PKqGKnMdegrwB8HG+3wpqUm+X3ognVzvep0+VCMad1RY/tWUSmVNT3Gr3uZkA/YAwMTX0CDcTHwaNVRY3uze6jHdxyjYrs
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0302MB3205;6:kVahSMT9c0m58pfrmpUnmMN7J5rAZygRY3ecmJnHQtlCG9zIDu8UDycUvl8rQQWYQ+K/opD7wVnJMUV6rbkSTroXex0PiWdOh1ZsveFLfFe+lH5dhH0SN+nr3TXM/bzyo2nwmNGaH6044Ve56IOTghEBAdOYUL8nptsKHgI7wu+FbZQ55W878Xw/VmBoBK6mgBG4WPR+Fb/DP6hnJmBrggwbZ9FX3D6rD6HqYHWuRxIP+Yh8vKu+MPblPmhxRZOGmrTCyfDOBjQ+AODuA+4gikdIJVn/Uxx7XnsUTNHREl9XK2ujUrBdw9j21i/lqhcR5FHALaOyoTf6jmKjwclftKSyRuGVIXqh2/uLHSISBrwBcOSs2MU+Y4ErywbrMK65YOKQifxxkpHqAX6NRey6DKQR4f7tjjNxGFnFUo6zGuJw9wZgWo1vI+wL8N8vsutlVGyBUU79mUfFmLbxAImnug==;5:+3SC+jxFm8/kt/+lGO1nCkdamlrMqNU1FQzmRJOMI6883QGsq9UKuEz7p2MttsxkjCxxWBKgl+sA9arO3y859a32j3+QfJksK+D74kMz1T6B9cNsR+8QE60/mpaNVeJuY8RDo7ljpjquZLxLdIV3SZqCjZKbouG3sH/C7+FHZX8=;24:m+CPnDTbS7PbAlW9puZay6ugWtI+aqo2Fv9eZ7lM0KfDmIq9Wh89p+BrEavzZBD+1WnbYYHL3aM6Z3grH0+8VM8GAH/nlbH7qlt6msll7fU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0302MB3205;7:IcjBkBIlssHL4gCjL+XlDOp/0BgM6sLDxZm6+nuBGeLsh35gIcZVHCSZOguK7Po/E1HLM9FlZ2D19luT9Lsd4a3KotAKewbIuaqOaJF9Xc+QL13aHzNkFCoTTMxzt8uYLzh3qHq4LyRU7po8KfhodPALAt4xp/3BMuz6TqsZG2k7bt5xOwVl/7r4VGG3/ArEJuBq/GruFCLGtIourd1tYIdwVG6kDiYTmDgzCeTj6YE7nPDPO19tXrTeF3tOiXvt
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 06:32:29.5148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c56714-2756-4591-41fc-08d5d289c50a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F4451C5F6BC93CF3F350F4FA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Please note, that this will need a change (attached) while
applying to the mainline kernel because of API changes [1].

Unfortunately, current Xen tip kernel tree is v4.17-rc5 based,
so I cannot make the change in this patch now.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d6ce86ee79465e1b1b6e287f8ea26b553fc768e

On 06/15/2018 09:27 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Allow mappings for DMA backed  buffers if grant table module
> supports such: this extends grant device to not only map buffers
> made of balloon pages, but also from buffers allocated with
> dma_alloc_xxx.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> ---
>   drivers/xen/gntdev.c      | 99 ++++++++++++++++++++++++++++++++++++++-
>   include/uapi/xen/gntdev.h | 15 ++++++
>   2 files changed, 112 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index bd56653b9bbc..0ec670d1d4e7 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -37,6 +37,9 @@
>   #include <linux/slab.h>
>   #include <linux/highmem.h>
>   #include <linux/refcount.h>
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +#include <linux/of_device.h>
> +#endif
>   
>   #include <xen/xen.h>
>   #include <xen/grant_table.h>
> @@ -72,6 +75,11 @@ struct gntdev_priv {
>   	struct mutex lock;
>   	struct mm_struct *mm;
>   	struct mmu_notifier mn;
> +
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	/* Device for which DMA memory is allocated. */
> +	struct device *dma_dev;
> +#endif
>   };
>   
>   struct unmap_notify {
> @@ -96,10 +104,27 @@ struct grant_map {
>   	struct gnttab_unmap_grant_ref *kunmap_ops;
>   	struct page **pages;
>   	unsigned long pages_vm_start;
> +
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	/*
> +	 * If dmabuf_vaddr is not NULL then this mapping is backed by DMA
> +	 * capable memory.
> +	 */
> +
> +	struct device *dma_dev;
> +	/* Flags used to create this DMA buffer: GNTDEV_DMA_FLAG_XXX. */
> +	int dma_flags;
> +	void *dma_vaddr;
> +	dma_addr_t dma_bus_addr;
> +	/* Needed to avoid allocation in gnttab_dma_free_pages(). */
> +	xen_pfn_t *frames;
> +#endif
>   };
>   
>   static int unmap_grant_pages(struct grant_map *map, int offset, int pages);
>   
> +static struct miscdevice gntdev_miscdev;
> +
>   /* ------------------------------------------------------------------ */
>   
>   static void gntdev_print_maps(struct gntdev_priv *priv,
> @@ -121,8 +146,27 @@ static void gntdev_free_map(struct grant_map *map)
>   	if (map == NULL)
>   		return;
>   
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	if (map->dma_vaddr) {
> +		struct gnttab_dma_alloc_args args;
> +
> +		args.dev = map->dma_dev;
> +		args.coherent = !!(map->dma_flags & GNTDEV_DMA_FLAG_COHERENT);
> +		args.nr_pages = map->count;
> +		args.pages = map->pages;
> +		args.frames = map->frames;
> +		args.vaddr = map->dma_vaddr;
> +		args.dev_bus_addr = map->dma_bus_addr;
> +
> +		gnttab_dma_free_pages(&args);
> +	} else
> +#endif
>   	if (map->pages)
>   		gnttab_free_pages(map->count, map->pages);
> +
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	kfree(map->frames);
> +#endif
>   	kfree(map->pages);
>   	kfree(map->grants);
>   	kfree(map->map_ops);
> @@ -132,7 +176,8 @@ static void gntdev_free_map(struct grant_map *map)
>   	kfree(map);
>   }
>   
> -static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count)
> +static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count,
> +					  int dma_flags)
>   {
>   	struct grant_map *add;
>   	int i;
> @@ -155,6 +200,37 @@ static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, int count)
>   	    NULL == add->pages)
>   		goto err;
>   
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	add->dma_flags = dma_flags;
> +
> +	/*
> +	 * Check if this mapping is requested to be backed
> +	 * by a DMA buffer.
> +	 */
> +	if (dma_flags & (GNTDEV_DMA_FLAG_WC | GNTDEV_DMA_FLAG_COHERENT)) {
> +		struct gnttab_dma_alloc_args args;
> +
> +		add->frames = kcalloc(count, sizeof(add->frames[0]),
> +				      GFP_KERNEL);
> +		if (!add->frames)
> +			goto err;
> +
> +		/* Remember the device, so we can free DMA memory. */
> +		add->dma_dev = priv->dma_dev;
> +
> +		args.dev = priv->dma_dev;
> +		args.coherent = !!(dma_flags & GNTDEV_DMA_FLAG_COHERENT);
> +		args.nr_pages = count;
> +		args.pages = add->pages;
> +		args.frames = add->frames;
> +
> +		if (gnttab_dma_alloc_pages(&args))
> +			goto err;
> +
> +		add->dma_vaddr = args.vaddr;
> +		add->dma_bus_addr = args.dev_bus_addr;
> +	} else
> +#endif
>   	if (gnttab_alloc_pages(count, add->pages))
>   		goto err;
>   
> @@ -325,6 +401,14 @@ static int map_grant_pages(struct grant_map *map)
>   		map->unmap_ops[i].handle = map->map_ops[i].handle;
>   		if (use_ptemod)
>   			map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +		else if (map->dma_vaddr) {
> +			unsigned long bfn;
> +
> +			bfn = pfn_to_bfn(page_to_pfn(map->pages[i]));
> +			map->unmap_ops[i].dev_bus_addr = __pfn_to_phys(bfn);
> +		}
> +#endif
>   	}
>   	return err;
>   }
> @@ -548,6 +632,17 @@ static int gntdev_open(struct inode *inode, struct file *flip)
>   	}
>   
>   	flip->private_data = priv;
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	priv->dma_dev = gntdev_miscdev.this_device;
> +
> +	/*
> +	 * The device is not spawn from a device tree, so arch_setup_dma_ops
> +	 * is not called, thus leaving the device with dummy DMA ops.
> +	 * Fix this by calling of_dma_configure() with a NULL node to set
> +	 * default DMA ops.
> +	 */
> +	of_dma_configure(priv->dma_dev, NULL);
> +#endif
>   	pr_debug("priv %p\n", priv);
>   
>   	return 0;
> @@ -589,7 +684,7 @@ static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
>   		return -EINVAL;
>   
>   	err = -ENOMEM;
> -	map = gntdev_alloc_map(priv, op.count);
> +	map = gntdev_alloc_map(priv, op.count, 0 /* This is not a dma-buf. */);
>   	if (!map)
>   		return err;
>   
> diff --git a/include/uapi/xen/gntdev.h b/include/uapi/xen/gntdev.h
> index 6d1163456c03..4b9d498a31d4 100644
> --- a/include/uapi/xen/gntdev.h
> +++ b/include/uapi/xen/gntdev.h
> @@ -200,4 +200,19 @@ struct ioctl_gntdev_grant_copy {
>   /* Send an interrupt on the indicated event channel */
>   #define UNMAP_NOTIFY_SEND_EVENT 0x2
>   
> +/*
> + * Flags to be used while requesting memory mapping's backing storage
> + * to be allocated with DMA API.
> + */
> +
> +/*
> + * The buffer is backed with memory allocated with dma_alloc_wc.
> + */
> +#define GNTDEV_DMA_FLAG_WC		(1 << 0)
> +
> +/*
> + * The buffer is backed with memory allocated with dma_alloc_coherent.
> + */
> +#define GNTDEV_DMA_FLAG_COHERENT	(1 << 1)
> +
>   #endif /* __LINUX_PUBLIC_GNTDEV_H__ */


--------------F4451C5F6BC93CF3F350F4FA
Content-Type: text/x-patch;
 name="0001-xen-gntdev-fix-of_dma_configure-API-change.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-xen-gntdev-fix-of_dma_configure-API-change.patch"

From bd96819f5c3fd94b878698ec8c1579c7115ff293 Mon Sep 17 00:00:00 2001
From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Date: Fri, 15 Jun 2018 08:55:57 +0300
Subject: [PATCH] xen/gntdev: fix of_dma_configure API change

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/gntdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 46cee32c2a37..fd680a8c8ece 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -604,7 +604,7 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	 * Fix this by calling of_dma_configure() with a NULL node to set
 	 * default DMA ops.
 	 */
-	of_dma_configure(priv->dma_dev, NULL);
+	of_dma_configure(priv->dma_dev, NULL, true);
 #endif
 	pr_debug("priv %p\n", priv);
 
-- 
2.17.1


--------------F4451C5F6BC93CF3F350F4FA--
