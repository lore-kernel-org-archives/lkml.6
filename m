Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 60769C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED054208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="PG2YRjE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED054208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeFNHAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:00:32 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:54912
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752781AbeFNHAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJuTHErVGUgiN/ghGdx8GwlU9m6hNKgewMg6qTApTjs=;
 b=PG2YRjE3nD9PH92mR3rZhx+GUjWaa/swQeiL6hNFtT55ytAnvs6H0vdXbDYKeDQ2mV0ZdM+i+9sgNvJIzV6owfptmWfrMRzQU706kPPLa1kx5Sw6INJKJcwMWH+sQ2nW8KNPe7Tw+uOXiOpH20FoiwCbvCrSqQqZKIL11d4oqPA=
Received: from [10.17.182.9] (85.223.209.53) by
 AM0PR0302MB3204.eurprd03.prod.outlook.com (2603:10a6:208:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Thu, 14 Jun
 2018 07:00:26 +0000
Subject: Re: [PATCH v3 5/9] xen/gntdev: Allow mappings for DMA buffers
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-6-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <58836503-87be-2693-4665-4b0a55a170d3@epam.com>
Date:   Thu, 14 Jun 2018 10:00:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612134200.17456-6-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0402CA0010.eurprd04.prod.outlook.com
 (2603:10a6:203:90::20) To AM0PR0302MB3204.eurprd03.prod.outlook.com
 (2603:10a6:208:9::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4b4993-f4bc-40fb-33ae-08d5d1c48218
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3204;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;3:aoUHuXytalT+lcD61pTrekw7/IHcCJQiv6QGuqc5oNXGbN83G9dnK5UdaP/Yf3cA9F8fhKRRoCaZ/3RJXZHPdG/mogSrhW39UL0VrAZJ1TQ+o9s9xSJMObX/VsqxWmSSEWZyyZ79I3AUyNul7ylUbD3A2pxnGhKANAoh+GdMx4NQcpaIi3BaMiky4Lv1Yzlhq0Zxr4LyS3qIWT1ubIL5y/vic+N/3yFybq/kYqC04Mu1WXSeGuSptnujl4hk8YD3;25:FdDYIqV4Fgyk4rlM9IKvmGbi5iQuqe7j5PJpOmp4x6qgiVvMOzQpaZAXCCQ7OWwJ3pzy//affmGe+1Dr7VCkBYHww8a481jZQd3fnccAjZ7Hih1wYfTHCbdH8e2VmvKsbHJt/zW4lZLJ1LyC6f/W4evNt+Le11Kz7Ntr+8oZu/m04OCpQrtrznzyohrQEP/BsE/e4RrUWZhFcjm9Min92ncDttPtvwJPY4YX0YFvTA9lmhXtxNOp38ttyMTytfyKyaimj5wv+nxjWWt3mWcJ8zpbAUynK8lY8A18xAnWhaIJ5Xr/g+dLus6vDNs4w+ANiSk58QHckAOobKO6FwpDlA==;31:yX9qz3dKF+hW1RzsnhaqxRuDXaIAJA0ywAUYB3/nR97WnIMvnspSDZjCpFkWSUXzIFROMgeAtx7ZS/L2ZKGB4IzJnYYgZSydLu38sVlm4m9UAySA5+uEpcO3W2fgwzrzv9tEqchcKgn+qENm9hMcUFYcmcTc6H4y3r9OQoiK3jVgt3L8vAHy8fOpWnM1xceSfKospwWWgOvp3FC7IKDgifOGO5CmMCX68xsH7gCEPOI=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3204:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;20:Z2kEVOtl7ocAPwSYIcLfuIdGisAe6xTWyOUMlO06vx6+M7cy92bQ59YspF3VlIiGVhjzNPng66moRJ4DE8m6+mBDyjP5XNqOt5Sbki+c6+QcvoSldo6AerZplSDI9mvgvntV19Mqcv88EhXKCHL3CJ7CZC21RstVVE8QvE0nXoHxaRCAUCdmBHwJPs4I8n9qoDyxdZmJ7HEV3pfyZV16afYhAHQ4lKNFeH+yf8WqPKWqWuL3FYJV8SDq06qqTHayc6FPnbLgXz56e6Z1dmxGbHV8XFTTmzNgof9hgW92rehSKxhqyDzDHhHfdXBUCu6FW05tLxL4a5qYHN8CtvQe0QcyqGYP4qDEExjBPdoarsTD41+1Zg1+ff7BntWeQt71dprMApC4HWXsuwBnBEkRuRZbLMyhPK0pBZEXTKYded/refJtxd+vJHyQUDl6i52Wuyg5fRV3I4w37f3M8pw+Wgi/Ps31LUU7ZaadaXjZwhZjjfFx+4KfkiEbBdFYmmFE;4:dsdIsv/vvB5jvndBOyoh2plE6+YHdQDLS/y+7qsw3UhQlDyyk2DPoN2qHXTk/ZaRzNh8K9QXBQ+sOhJXsspxnoHJAUCpPAiZYHz4C+09rI9WMP5jzYOB4Lm52y+sdUFqagK82clNI8O/NxSvNIvMh+vioaITX6jr/5FZ1orRQbCnUgArpK8rsAjYXNC+zf7rA54596IB0wb0o4W/9ad8qVZf/++Yoyy/hF+zyYlk5LKH6augXlc1VC9oJEw/mh7taXI+FmEwQNoeo3atH5Ejc+qlHYIXC8WNSnPRuJOjRx470KsdomSIbmWvkuozHBzN
X-Microsoft-Antispam-PRVS: <AM0PR0302MB320498CD47DFE636F90C6DECE77D0@AM0PR0302MB3204.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3204;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3204;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(189003)(199004)(52146003)(6486002)(52116002)(80792005)(68736007)(86362001)(47776003)(5660300001)(97736004)(65826007)(64126003)(7416002)(186003)(6116002)(65806001)(446003)(77096007)(67846002)(66066001)(956004)(16526019)(23676004)(3846002)(31696002)(229853002)(2486003)(36756003)(65956001)(11346002)(6666003)(316002)(39060400002)(966005)(81166006)(81156014)(72206003)(8936002)(4326008)(25786009)(7736002)(50466002)(16576012)(230700001)(478600001)(6246003)(476003)(106356001)(58126008)(26005)(6306002)(2906002)(53936002)(305945005)(486006)(55236004)(8676002)(386003)(76176011)(31686004)(105586002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3204;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDQ7MjM6UCtqaXl5cCtUZjU5elRJN1pLajJ2eGtK?=
 =?utf-8?B?MHBHMWNFUVk2d0VlT0xZN3BQN0VGZ29pQjZ6TTRRQzlmNEJEM2o5clNGZHho?=
 =?utf-8?B?SWNERU5wZWVQZHIzZ0p4eTB4YVdrclVMMklLbGQ5d3g1eVk2b0RESVRCU1Fo?=
 =?utf-8?B?U1YyY3ZkcGV0emovbmhtaFZzT0F2RmZReGZMM2FqMi82WmJkb3ZYZ3hvNmlX?=
 =?utf-8?B?UEZ0bnRmc1pCcFlzbFlRUk1xWExJbkxoekVjaGN3a2JScVhHT2N3Um5vVW1h?=
 =?utf-8?B?S2JKWnkwN1lDSHpia1lHYTdXTmJUWjRjYzRVZ1hUa3pPZDFFM3ZEOEh2MEVi?=
 =?utf-8?B?cVZaSm5NMjRKZjAybVZCUFdnWXJXdFhXVzJwekg3R3BjbHRWd2VOc3RQV0J0?=
 =?utf-8?B?NzBacDhhOWlMd25aSW5kM3pyZTE2V21PSzlUckN5aXRSOGNWQ2tRaHA1bTdE?=
 =?utf-8?B?TnczSHlQZXZTOE5pWXNueVdlNmx6eGsrSWtjc2ZEeE8weUtVcmVMTzBZT3Z5?=
 =?utf-8?B?TURUOUd3UWI2MzRaYUhiUklkdlpJU0ZUd0swYUlNMmJ3bEdRVFlSY0dnY1I3?=
 =?utf-8?B?Y1ZWTnpqb2RvMEt2aEgrbVQ2a3ovVFc4YURxbDJnMEo5ajEzalpIUFJNVTFJ?=
 =?utf-8?B?OUNJZ2FwekZ3S1V3TDB5QmM1dHdQckRnQ3hpQ2NzRGRMSVpTNTZBeGtvK3Vo?=
 =?utf-8?B?cnI5Z1VXYXkvZWYzZk9GOEJGdVlSSjhwZTJiWjFaMEJXRGtoNU11M3c2cEkw?=
 =?utf-8?B?UHlmZk5PVTVIU0hRTDR1akNudDZBOGpQUVJSbG84STF4NC9RaWJwM3l3clo5?=
 =?utf-8?B?dVpHUzU3eXczMFQzd2txYWw1aGxBZ0MzWXJncFV4a1NhSThkNFRFMTVaUHFz?=
 =?utf-8?B?d3dMRjdKTkY2RG5IRCtCaFVyRE5Pd3VHMmNLcnJrb0FISUZlbXpwSVE4UmdZ?=
 =?utf-8?B?Ukt4UENhdFY1Skp6bWp4eGwrMDVIMHQzTWVWQ1NWbXcxQjlpVWZvSUtKRERG?=
 =?utf-8?B?a2dRY1kxV0NIR0JLcUFFc0JYdTJBQWZZSWhJTlN1OUlWS09xK0pVdlJNbHQ2?=
 =?utf-8?B?VmJMT1lKcXljVjU2VUdFc3FGRG9vM01NZlcwNTJxTDlERzB6NGFPVnI2eGNJ?=
 =?utf-8?B?YXZLWm84WURERUkyM3FMSHd6MDVTVHNaQTBhdER6ZngvN3ZScmZZeGFOMjNJ?=
 =?utf-8?B?WDFaYzFtSXBJbjhnb0tSWTRUVGRXQ1lGc01vajNlUEJVYTNEaXZyK3FaRjFD?=
 =?utf-8?B?ejFtdUt0bi9NZndocEpHVHJpVGI4M2JSNnlNOCtCeFRSQ2RVMVBqUnZrUzdX?=
 =?utf-8?B?Qy9hV2NyVVdVLzRhazA5eHFZZVlRQnFMZGhDSldIVmpYcE1mQTRJaVBtblRO?=
 =?utf-8?B?ZStkb25SSTRiTW13a3dVWHlEbXRNS1FiQUdURlVZeWJFRGh3ZWdlOXFoNm9w?=
 =?utf-8?B?ZWVhT0E0aGNzS2RDSHp6RE1FTmtwcnFzcHgrZGhSQnFGM2lHajhzS0QwRzZL?=
 =?utf-8?B?ckVRRmJ4TExtekhvOWhqalhuaGt6VzZneWhUeU04U0dDV3hBWFpHMEJyV0JJ?=
 =?utf-8?B?UmZHbXhCWWtIZU9sRHNtWWR0MVcyQjF4L1NuZzZxNGZ0cG1tQlBaWjZTYTRr?=
 =?utf-8?B?RUl5T1RqM2xCcUpxS0xkYTNuREV4eVJUeWlDOEJsblFjTHBJcXJpRDdQQWhO?=
 =?utf-8?B?RkRZeCsyRWU0eG8vL09yT1krSG5qbVdZYVhpdzRYamFXU21aZjhHa0ZvTmIx?=
 =?utf-8?B?WkZoUEJmZVFuK0ZueFF6TmhGQmFVUFhUdXI3RXBvTFVmVHJuV09qRTF0RUM4?=
 =?utf-8?B?RDdxUW83YSs3czZ6dUhqOHpOWURZK05nNTNMT0wya1VadmVFRzNENS9WZFZ6?=
 =?utf-8?B?YzM0STdKZzFIZEdDUjhXYVM2dTd0MUFPdUd1My9aTDF3ODF1T0QwOUZ4eDNk?=
 =?utf-8?B?S01BZm9nSVp1eVhVVEp6TlpYRWh6eXJvREViVWJFQTBMWTBlZ1ErdkU0b3VT?=
 =?utf-8?B?NzEraFVsei9TRnZ4Z09tTkZKWnBmY2thWHVRTGg5RDBGaTVOcjgrRHpUQmRZ?=
 =?utf-8?Q?5ng4T0n8K/LSMW3iM011n2QgdCk?=
X-Microsoft-Antispam-Message-Info: 7GAasxiKz00OsgFPNlgx/DXzTTZG1bRS1ZW7jn0f1Q4DmN6v8ULMsug6vUqwmfVnrR+IhmG7q5H9W1pso8pDFD8NCzu77Ayy58P0xM30jIcmmK3YfrJNSvJqROjryBC1n/iZl5XmljguVnt3Gv4MrgROXj82giKyxuCdPmAo2LDs2lKeJNTmy2R7M13XBZVS
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;6:ZuUft5xKTbaqDd57dgwTBeyWc9sIz86xwVHbjYLHXio41Xw+Vkz6gEYe3kwGUS1VpFPezKOeXO3r4GGsKEOUBohgm2uU6aHHkO45FrAWio9sEHTynhJhIKVfm4XG+eAxmaQS0YcqNIAv/ugiSnZ7Ip+oNmMw6fzPLBYU6D8EDhX9cjzGlCQ5EMolhTYcI4Kx3dcD6P3dWpSNqsHW9nR+V9lmen6tGZ0Ei9v9VuDD6KCEKecik4jVjET/4S104s/7JEzc1uoDq+lsKEFfTCtGJalzUrcyk0MKFy7tqvadwHWZODYp8BPciV3f5Wv7zdtovfnSlEPOpopIOnprZ+3QI44Y5BGQu6fa1ACaNhhrLz6tLuLVC0sK7cynWO84uMn6+47pU9oZIAnEUO5cDglSiP5Evl6z6sbfM5wsoWarpGsrYPDt4eCQhj021QvTdi8rUhK/P+El+YCbkwRcSXLUVg==;5:wDNNdEqnnv1PAX+wiq5A+D2siOZ+RxYWcqSRMRFZijJgjYoSgnvE4TNYo/59mxP7Ddo8y0CZN5p6WfqnRKvXz3ZwaAd946DzcorFek80CodAJ/pbpgF5veHSjGn1W+Kc41Qo+pGhjkBpy3q0THg+Vl1ir50Rsd6ypeDyJgTSn5Q=;24:vA8QIfk6FAtsNm7yq6PJr749NQSW0YRp6fiQyyNaB5mFqecRV/Fn9/vie3ga4OofqGc7nk7qZGpEppnc2xeeVcqD6cRuYqv4H0oPjBSzPZw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;7:P/iDgdGyCAJeeU6zUfFADbdaMFwes2NhZhuW8bYJlW+k5EH+bOJeSTz7VtkKqI2Voq+sFmwlq2nVUgeeqCQrFcjXBJUG39qHR1PGSggViIsTnlnDR1R+X0xxtTW0n/bOln3sOmLBGU1xwhycQou344xwnaP7u0G2HqRRL9F3AeLsAASJV8VY8rj/M87FYwoKOiqdlBScDwN6VEFDnhVMmylYvPtapWW/XvXDQGRXFC0LpxeNwplSzgAa1mxmUqwk
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 07:00:26.2888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4b4993-f4bc-40fb-33ae-08d5d1c48218
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@@ -548,6 +632,17 @@ static int gntdev_open(struct inode *inode, struct 
file *flip)
>   	}
>   
>   	flip->private_data = priv;
> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> +	priv->dma_dev = gntdev_miscdev.this_device;
> +
> +	/*
> +	 * The device is not spawn from a device tree, so arch_setup_dma_ops
> +	 * is not called, thus leaving the device with dummy DMA ops.
> +	 * Fix this call of_dma_configure() with a NULL node to set
> +	 * default DMA ops.
> +	 */
> +	of_dma_configure(priv->dma_dev, NULL);
Please note, that the code above will need a change while
applying to the mainline kernel because of API changes [1].
Unfortunately, current Xen tip kernel tree is v4.17-rc5 based,
so I cannot make the change in this patch now.

The change is trivial and requires:
-of_dma_configure(priv->dma_dev, NULL);
+of_dma_configure(priv->dma_dev, NULL, true);
> +#endif
>   	pr_debug("priv %p\n", priv);
>   
>   	return 0;
>
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d6ce86ee79465e1b1b6e287f8ea26b553fc768e
