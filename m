Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC518C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBFC208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="Xpyw3Exa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBFC208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934064AbeFKRuR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:50:17 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:64356
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752226AbeFKRuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUqPUerWS0SFN4JlmRmUKkMQwq2QGuVZswmIDTHKpTo=;
 b=Xpyw3ExanHrnLrgQNOdROjaJXlfPgMsMQy+VVOEEEbpVSBCgPRymN4t4kOGlgdnqEX/sfisaaFHjwoyIRMkaTP3ZjqnnT6gEJ7BKW4FAnc+ablTCqE7wdvBnMnenvULenlCnkBTXQm2vAcKsG8cjtmnKWeejqRJmGykHk/ZJt5Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [192.168.1.122] (46.211.157.57) by
 DB3PR0302MB3212.eurprd03.prod.outlook.com (2603:10a6:8:9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 17:50:05 +0000
Subject: Re: [Xen-devel] [PATCH v2 5/9] xen/gntdev: Allow mappings for DMA
 buffers
To:     Julien Grall <julien.grall@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com, daniel.vetter@intel.com,
        matthew.d.roper@intel.com, dongwon.kim@intel.com
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-6-andr2000@gmail.com>
 <64facf05-0a51-c3d9-9d3b-780893248628@oracle.com>
 <84217eac-b83b-710f-39ab-c93cad65bf9a@gmail.com>
 <a172746d-7a97-159f-71a7-511b2d239089@oracle.com>
 <30fa03c0-1b75-c0b1-b14f-8b52ea584e20@gmail.com>
 <78dc2fc4-cdac-05b7-2c34-22b69e7e009c@oracle.com>
 <4be24882-185d-01e3-6aa1-751e341433c7@gmail.com>
 <alpine.DEB.2.10.1806081025030.14699@sstabellini-ThinkPad-X260>
 <c6e1820a-fb57-b213-aa2f-05787dae06ad@oracle.com>
 <06eff3fe-3ffc-47f6-6bd6-d8f2f823b382@gmail.com>
 <alpine.DEB.2.10.1806110949050.14695@sstabellini-ThinkPad-X260>
 <baab493d-bcba-f053-4b48-0f97fb5723b2@epam.com>
 <33984b9b-966a-78bb-0472-37af23b8ba9d@arm.com>
From:   Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Message-ID: <c5a94f8e-4b9f-a5e5-aac2-fc9fbd5503de@epam.com>
Date:   Mon, 11 Jun 2018 20:49:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <33984b9b-966a-78bb-0472-37af23b8ba9d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [46.211.157.57]
X-ClientProxiedBy: AM5PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:206:1::14) To DB3PR0302MB3212.eurprd03.prod.outlook.com
 (2603:10a6:8:9::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3212;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3212;3:icR1pAYLtAlG+UzPhYoSmZMVxOFCexyD2YY6LyZAWZiqeMpT0TezJNM1aJaDFvLnesKfaDABo/ckWfEE1Dzbq06V2SFB14a4z18uAGFzsfykHUiLwwI/cmwS/Gali8umy49wnrMUUpGMexHC5z1hxepW3Oa5TfvBjJJWI24/eDMSIJFr89pllklm2bvvY8oRk/07Ch650e4DkVCMsYRcLI5qcoQpXST/zELTKWaeD96C75NingV+a8WMrAZl6iat;25:1+jIkdZbuueR+W5pvG0q6mwH5Bn14triHLLqJ26gfpNomDfiGXQ+teVKeBRp76WhkIk/5AYV0sBrTbKlN1nJYhvq+5nftIcg/sAH9AcP8Vo2w4KN7S88M1UiyckSrt/j1ruMj7tyloRN6z6Tl75JYkdeUJ5u0S/RdvivMIxi8hTGubBVt/MMcNH8M+K4g1dzVxQ0rTEQPxzNM0gHR4nc7AEMK68r2jNJLvzFaihx1TLkvyzTET8H173Yz0Pgc1DPOn1u6TxnQcS2ZGCUkfs5UHH8fBYxd/5xkaTGoIbgDUtcS30gG0pIZh/vfA+L6LIp0UsVQvz2lqHQ9ce7Op1d+g==;31:qQVqqzTYxprmuLjN+kmal6OTCRZiB6rSlrbrnx1uTUZsK0VKttEw+YLE83Ccf5k29n9tYI4bmjRNHg9pKZuDQtmgo1uzxWx1hsnGxU8QddvekC5F58iabWRoTR8m/PXTJGLfoUdfi7zJ57ptsTjmKQ4dROOgsTdwt62uqQX52h2cSfFZwLZrD8O+zy5Nq+mJV+5+bfFkrRn1QZ33+RWiYGP2NwewwYwmV979BDoFhRg=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3212:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3212;20:yFKcMb/AbTk/8H0kDN/eZ3URLrt0IiSGSGzyc2IOt73YWakFUrhZEZ0Rp+BIpuomoUOhIanYk0wPm8jtKXIG/YSy+p8C1GXd1N5X/RrFoFkURS15y5n1jA439GhlpkAjnlA7mrjptEWAgR9GCwrwCRaCNjTdY3CwUyrqAxykNKmFQ5Palyl14pe4ow7VLycFhDC1MCwBcbDjYe2Z9tleHoYfYGBjFKEI31WI/jLmsX3zN/oSC/ZCI505gfTPLF7KSydwfYPsqb8AyMPDmnvzdeIY2+Yif0nltSrQ+sX/ZM9qzcycgu+5nEkgyj+1955psnRmKno1rVc5w6dZPfMn5NsRm+xZgjpbVHabOYNm/QEFinNqMe/DfypwxfDwSw/3qsnaHUBbU8WxXwoeNYbicdG4XsNw038JCZWCaE4vdqou6slyCPHJU6QiYo7UWnljpe3Asernl/CvdZZhvHC1WvzQftUPA/pitKejGfe4VhIykzY/Y9G+V7NfaRIQVDur;4:tqoQ7Qk8f12V1TupLq3oW3YFD4EYUNNpjiqz9GKo14iHTnHir2Qx0kDA1eOfy1V6F5b+kDdSgsSR4eGlIZGXVOb6ZIrHPhPw0TF06x/Xux+xhFZ58OTVr22DDX7y6V4IzUOtzzzREbZU0Gmb5dqlAh8pChIgVWECLQ0dYZgFcx4NmMdwMjHF+PdNDwglLoYnzb3mDULsTQDuEeju++W9O1ccjajhC+DaIh1CyOyTAXzEiXC4/6PkOZyP9yplG14gAP3c4rxidcwJuXdFU37NfA==
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3212964E59F6ACF567CC0509E7780@DB3PR0302MB3212.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3212;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3212;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(39380400002)(396003)(376002)(366004)(199004)(189003)(81166006)(66066001)(68736007)(316002)(80792005)(93886005)(16576012)(305945005)(6246003)(39060400002)(53936002)(97736004)(2906002)(26005)(67846002)(65806001)(72206003)(65956001)(55236004)(7736002)(25786009)(64126003)(4326008)(186003)(8676002)(65826007)(229853002)(47776003)(2870700001)(76176011)(478600001)(6116002)(50466002)(3846002)(31686004)(106356001)(386003)(59450400001)(105586002)(36756003)(8936002)(110136005)(16526019)(77096007)(6486002)(5660300001)(52116002)(81156014)(58126008)(7416002)(86362001)(52146003)(956004)(6666003)(11346002)(2616005)(53546011)(446003)(31696002)(2486003)(117156002)(23676004)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3212;H:[192.168.1.122];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTI7MjM6RFliWHpVQWtnb1pNbVczMnN3akxWOEIw?=
 =?utf-8?B?dlp4TWxvd1JXTHZaMTVUUkJqWWFrVDNFQWVUelEwd2JtOUtQNmptaWR0QUN2?=
 =?utf-8?B?RGhjbDErSWQ1Tm9ET21FZCt2Uzk4ZzI2dlY4cUJQRG9rc2FSL250Mjdla283?=
 =?utf-8?B?bytzMXMxek5xdE96c1kvNDgyV3grRDd6SGI5UzExQjRBZURhWmVIS3hUblAz?=
 =?utf-8?B?Z0wzdU1LaklMSi9TNzByQ3Q0a2svQU1LTTRpaVc5S3VyeFRmbkFlQUNmSU1q?=
 =?utf-8?B?RjJLSG4va21Fcjc4M3B5ZFg2c005Rmt3ZnQ2cVZxYUEwRHcxcFVER0d6aElo?=
 =?utf-8?B?akxMdE05QUR5S2txTEE3dGFSeDFxREQyNVdsUTJENlFtQnh6NXNFbnE0SGNh?=
 =?utf-8?B?UTl3bkpTUjdmOGpoSlBoMTVpenB5YTRKS0dnZ1IveC9VMUtQMHU4M2pIR2lR?=
 =?utf-8?B?RXRydk1DR0E0MWF1YVYxSmxFY1ZQRU5SWVlxT3c0blBOVkxCaE5Vb1QvWHN6?=
 =?utf-8?B?eFZWSFlPWVlMVDc3dFZSb1pCUndaQ2dIakJna3l6dFc3UE8vSTJqcUMxSHV6?=
 =?utf-8?B?NWZVQkJIempKOW9uaE1qb21jL0J2SmFwaDRKZHpCeXB2WFB6cXY0aEx4WGJZ?=
 =?utf-8?B?eVZTSzcxVlVYaGl3UkVrZzNjVlBTMForYUR2eVJrUjN3TGJUekJaNlo0ZDNK?=
 =?utf-8?B?VW1vTVpoWUswLytPc0I2R0hYeENYV1ZHUlNvWlhObHg2SnY0TUt1dDE5QkMz?=
 =?utf-8?B?YWRoQVpJa1N2aVVybGlYd1YwL05ydnMxTGh6UmZHT0RZakxtS3dzMzN0YVJl?=
 =?utf-8?B?R2JiSTZ1aFl3TUEzWlhhT0pZcnNES0R6SGdMMW5IQXd5M1hjMDU0OGdOMldr?=
 =?utf-8?B?c0Fsc2JyUnZSbEJ0L0JFaTg5eDJkM2RTbndBdEgwbTVmTjJjWFpsQUZTeEpi?=
 =?utf-8?B?WmdPcGVGZWI4cGJkZFczek4wdGEvRVQ2MkQxVkx6VmxYdTQ4bDBieFhGSEtU?=
 =?utf-8?B?bGttY2k1T1ZrT0crbUlFZ2dHdktSUUhkUnVjalEySUdWeDk2enJtUk1QTmhF?=
 =?utf-8?B?dFVjb0F2VzRMZG1QSE1YMmczRU1uL2l2b1JBUFRYall5eUJqV1VuYmZYcUtF?=
 =?utf-8?B?SjRTdEpIU2xjZkdQNE5FcGl0Ylh0blo5cGV6WlRKVmVxL0ZKbVBUam5ZT3hr?=
 =?utf-8?B?R3dCb2RiY3QvQWxnR2JXckRlT24ydms1andBOVBLb1RaODJLVUloUzZXU1Ey?=
 =?utf-8?B?aW9tKzZEbEx1QSs1YzBpSFdjWDVyeE1qRXFNYmtuVFZ1KzZHVUdhTENNMktV?=
 =?utf-8?B?SUYveXBOVlBpR3o4NndEa3BsUWlaU0JUZzYybmJuMnJWMzdlbHNYNmNRNmN0?=
 =?utf-8?B?Kzc4ejNLeWZKa0VVdG83Z05pZzV2NU5JUFUzdHBrR0V2U0RHNy9IM0ZvcGZY?=
 =?utf-8?B?WFE1amZHekNzT0FveWdvL0dPNTQzc0dzbVB1TzhzcDgvTTg1bTNzNlI0MWxZ?=
 =?utf-8?B?RHZRcVNMOXp0bUo1eDYxem9xZ2d2cUZrK2FSK1dKRi92OTgwOFlCVkd0d3lm?=
 =?utf-8?B?ay83UmYrOTQvSUhSVkpHSXlORzNWdkxJUGZaa09SYlpZNVVORldHVHJHcm9W?=
 =?utf-8?B?MTBmV0YyaDV4bGFtVWYyMERuVTlUMTJpTGZhQjJXSGg0NUVIQVlnYjBucXRq?=
 =?utf-8?B?M0hYUmVZMGh4RSt2U2gvL0xPVDF5czd4TnlXQ08xVmlNUFh0TXZCbVR1TVdG?=
 =?utf-8?B?azJndEZVMnh5anUwMTlTT1drbkt0aU1YZi9nc0oyMm5qZVlBMlBmZy9LVFdZ?=
 =?utf-8?B?NXBCUysxQW1Ed0RReC9wSktjMUVBTzg5RjNHcHBkN2dqcUhlRXlJWlMxVFdJ?=
 =?utf-8?B?MWE3NzNKZ05FM0ZYb0h4NUp0c1RkQmJxeDBRbEdWVDM0WFdnaXRIdGNpbFVT?=
 =?utf-8?B?NjJrWC9PT2Vkc016UlBnUFZpSTR4NWxCc0tvUVV3WjZkMDhUNE9MWnQ3OXcr?=
 =?utf-8?B?cVRMa3pTV01XcTJQRXBJSnQ0NHdmREh6V0dxdmNrckhhWktSekptU21teFFV?=
 =?utf-8?B?a0FlK2xadUxQN24zVmkzTzlMNkpoNEM4N1R2NWtONFZXbUkvdG9EamM2UE90?=
 =?utf-8?B?bUtLMU1lRk1oS2pILzdEVmRHd2FWRCswclhCeEpoNWpLd0xZNEtnWGY3Tm96?=
 =?utf-8?B?dHNGSVNMd3hoa1ZyQmpxdElyTzk5TFE9PQ==?=
X-Microsoft-Antispam-Message-Info: ii3AVaBBcQhDQhWpzRE9LyjhTdDj1ZVlI+OTrDLjD27R2e1TukR2ytbVJJ3wo6XlQ4ljcZfS9FKAKiiKN65zoFgkLfadIKok7z2B5GpTQ3jJab5hE5zSlzqZOxTqZGXMHQNexp8eMZeSCwdWcgSzOjaEQ2SZI4hQoULpdoraNrfQUV2heItE7R1KwhPnbX8l
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3212;6:e9ickVYt5TMZid80AEk/h1aO/Wff/UB0YGsLIyHq18j9pbLtewaBQD7SIf0pDtAsHnnd+zxBw/Ygr2cqUZXMLULTxymIb+L53Yl1euvtb3/Z0gwHApCGqBPaVwDH0RH/uhFy3gKu1NxKkb2bgF+0GTXeCe1F+8agXBtTLorRL0ctV11vxrFxCIkz6q99U36IYZ/BeIYS00pL59P1fJ3oqpOgIbRusQOdR0tWL41iyvOrzD1s1k48diJMhv0HSVqNfMjLKJpRanPVYqguuw7PMMaauvdWaV9o62178fYiI9HNIDgm2jTmKr8iS4omwiM4el8ENvN9V9CHXDsRNcXjmrka8672Qb81vSEgErHNt8j7J2CjL+0WdplZFHSFp+/6irNj5N66FR7tXkKzYHr7ihSaVhPgmlOciPo+MSBy4mwMjOxhtnnnfedptjzl/BosBlKzjGYBiJh/q3uDMlRFSA==;5:6AoCecPjdxacG/31IdNt/qYCliBhmGZ/2R7FbArmjm6yxrtenffTBCvc3DVceleZMq484Rx9lZP6tvvKIYyuaDJVcketAqW+En/jL/Qh7YcPLRcvfcgWHEmfpul4hQ4G0TiHIiX8dUU2lTddEk0YC8O0x8MXmcjC0515wFFXsF0=;24:bfjJjSZxhcv+0oKZqwZlxCnfcN6e9cPFhtsGDLgTS/AMspdSO+wUaZOxPsi9O0z7B2XaGCDDSqe9Ni2sWNMRzaJUrEdcu0LVB4z6Q0EPLek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3212;7:boD4A1KAJm4lRG0a3nMYklPawnGsLJkN8BMqGDw6g/JA0SJx96ejyU5txkCP1bqNAl/pp7kgTSK+S5MhLo0iw1dJP6mm57uI8nxOYQJLZ+s/8MEfKgZy9KQDp9thuoQuikQV4iyGlpJkNtN4xr1OgyAnLoo24uk4vrULaU+RaQhGtssJneJd9/QTeVqYgbE4RJm4gOi8AVe9pVa6oE8tH19zEXMgGSs/We0TVd+6YzDTBnXdR3zyTMSeTPrnP+X+
X-MS-Office365-Filtering-Correlation-Id: b6f2980f-4e36-4864-c052-08d5cfc3c6a6
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 17:50:05.7930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f2980f-4e36-4864-c052-08d5cfc3c6a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 08:46 PM, Julien Grall wrote:
> Hi,
>
> On 06/11/2018 06:16 PM, Oleksandr Andrushchenko wrote:
>> On 06/11/2018 07:51 PM, Stefano Stabellini wrote:
>>> On Mon, 11 Jun 2018, Oleksandr Andrushchenko wrote:
>>>> On 06/08/2018 10:21 PM, Boris Ostrovsky wrote:
>>>>> On 06/08/2018 01:59 PM, Stefano Stabellini wrote:
>>>>>>>>>>>>>       @@ -325,6 +401,14 @@ static int map_grant_pages(struct
>>>>>>>>>>>>> grant_map
>>>>>>>>>>>>> *map)
>>>>>>>>>>>>>               map->unmap_ops[i].handle =
>>>>>>>>>>>>> map->map_ops[i].handle;
>>>>>>>>>>>>>               if (use_ptemod)
>>>>>>>>>>>>> map->kunmap_ops[i].handle =
>>>>>>>>>>>>> map->kmap_ops[i].handle;
>>>>>>>>>>>>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>>>>>>>>>>>>> +        else if (map->dma_vaddr) {
>>>>>>>>>>>>> +            unsigned long mfn;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +            mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>>>>>>> Not pfn_to_mfn()?
>>>>>>>>>>> I'd love to, but pfn_to_mfn is only defined for x86, not ARM:
>>>>>>>>>>> [1]
>>>>>>>>>>> and [2]
>>>>>>>>>>> Thus,
>>>>>>>>>>>
>>>>>>>>>>> drivers/xen/gntdev.c:408:10: error: implicit declaration of
>>>>>>>>>>> function
>>>>>>>>>>> ‘pfn_to_mfn’ [-Werror=implicit-function-declaration]
>>>>>>>>>>>         mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>>>>>>
>>>>>>>>>>> So, I'll keep __pfn_to_mfn
>>>>>>>>>> How will this work on non-PV x86?
>>>>>>>>> So, you mean I need:
>>>>>>>>> #ifdef CONFIG_X86
>>>>>>>>> mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>>>> #else
>>>>>>>>> mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
>>>>>>>>> #endif
>>>>>>>>>
>>>>>>>> I'd rather fix it in ARM code. Stefano, why does ARM uses the
>>>>>>>> underscored version?
>>>>>>> Do you want me to add one more patch for ARM to wrap __pfn_to_mfn
>>>>>>> with static inline for ARM? e.g.
>>>>>>> static inline ...pfn_to_mfn(...)
>>>>>>> {
>>>>>>>       __pfn_to_mfn();
>>>>>>> }
>>>>>> A Xen on ARM guest doesn't actually know the mfns behind its own
>>>>>> pseudo-physical pages. This is why we stopped using pfn_to_mfn and
>>>>>> started using pfn_to_bfn instead, which will generally return "pfn",
>>>>>> unless the page is a foreign grant. See include/xen/arm/page.h.
>>>>>> pfn_to_bfn was also introduced on x86. For example, see the usage of
>>>>>> pfn_to_bfn in drivers/xen/swiotlb-xen.c. Otherwise, if you don't 
>>>>>> care
>>>>>> about other mapped grants, you can just use pfn_to_gfn, that always
>>>>>> returns pfn.
>>>>> I think then this code needs to use pfn_to_bfn().
>>>> Ok
>>>>>
>>>>>> Also, for your information, we support different page 
>>>>>> granularities in
>>>>>> Linux as a Xen guest, see the comment at include/xen/arm/page.h:
>>>>>>
>>>>>>     /*
>>>>>>      * The pseudo-physical frame (pfn) used in all the helpers is 
>>>>>> always
>>>>>> based
>>>>>>      * on Xen page granularity (i.e 4KB).
>>>>>>      *
>>>>>>      * A Linux page may be split across multiple non-contiguous 
>>>>>> Xen page so
>>>>>> we
>>>>>>      * have to keep track with frame based on 4KB page granularity.
>>>>>>      *
>>>>>>      * PV drivers should never make a direct usage of those helpers
>>>>>> (particularly
>>>>>>      * pfn_to_gfn and gfn_to_pfn).
>>>>>>      */
>>>>>>
>>>>>> A Linux page could be 64K, but a Xen page is always 4K. A granted 
>>>>>> page
>>>>>> is also 4K. We have helpers to take into account the offsets to map
>>>>>> multiple Xen grants in a single Linux page, see for example
>>>>>> drivers/xen/grant-table.c:gnttab_foreach_grant. Most PV drivers have
>>>>>> been converted to be able to work with 64K pages correctly, but if I
>>>>>> remember correctly gntdev.c is the only remaining driver that 
>>>>>> doesn't
>>>>>> support 64K pages yet, so you don't have to deal with it if you 
>>>>>> don't
>>>>>> want to.
>>>>> I believe somewhere in this series there is a test for PAGE_SIZE vs.
>>>>> XEN_PAGE_SIZE. Right, Oleksandr?
>>>> Not in gntdev. You might have seen this in xen-drmfront/xen-sndfront,
>>>> but I didn't touch gntdev for that. Do you want me to add yet 
>>>> another patch
>>>> in the series to check for that?
>>> gntdev.c is already not capable of handling PAGE_SIZE != XEN_PAGE_SIZE,
>>> so you are not going to break anything that is not already broken 
>>> :-) If
>>> your new gntdev.c code relies on PAGE_SIZE == XEN_PAGE_SIZE, it 
>>> might be
>>> good to add an in-code comment about it, just to make it easier to fix
>>> the whole of gntdev.c in the future.
>>>
>> Yes, I just mean I can add something like [1] as a separate patch to 
>> the series,
>> so we are on the safe side here
>
> See my comment on Stefano's e-mail. I believe gntdev is able to handle 
> PAGE_SIZE != XEN_PAGE_SIZE. So I would rather keep the behavior we 
> have today for such case.
>
Sure, with a note that we waste most of a 64KiB page ;)
> Cheers,
>

