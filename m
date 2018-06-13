Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8E3DCC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1662086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="hMdljyfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1662086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934625AbeFMHQR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:16:17 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:4832
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933999AbeFMHQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrkLV5kYxNZafKjOD2bxpXdbzE9XV56MP5smp0CC7Ho=;
 b=hMdljyfVjZ437lYeT92w6F8YZe5f4CHJq6ApkrVnVpaHTupmlj+NcmLgg2Hx9Q/rbA/PBEvIjb/4YDUytFkvecZEiqdliDuMgsBQ/H2KfztlyvhVX2O7kfsq5BTprvKw3+yzSh7bTXQD4V15ynlYcdnNpSh7SxtARDKdlER7dVw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3215.eurprd03.prod.outlook.com (2603:10a6:803:18::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Wed, 13 Jun
 2018 07:16:10 +0000
Subject: Re: [PATCH v3 5/9] xen/gntdev: Allow mappings for DMA buffers
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-6-andr2000@gmail.com>
 <b78251d7-462a-fb1f-32e9-868a7236decb@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <1a79c485-e0bc-d987-32f5-5fdbc1722b6e@epam.com>
Date:   Wed, 13 Jun 2018 10:16:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b78251d7-462a-fb1f-32e9-868a7236decb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0202CA0013.eurprd02.prod.outlook.com
 (2603:10a6:203:69::23) To VI1PR0302MB3215.eurprd03.prod.outlook.com
 (2603:10a6:803:18::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6718ceb9-cb45-487d-2e2d-08d5d0fd8a65
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3215;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;3:YBeE8JWY+/7tLFsN6nwEy406HcwJLga0DnvsmPa6NqnCtp6ezx6QORJ5XuXF1YIEJcwgINv4fMvnNLFz4ufSFe0mA9k69gEQcUG8slFbBqVBdKuqnSx2WsGbGY1pqxIx4RUPViIcUpAKwaI83DWZGgRAoo7ofJ+EA15aFO8Gr4OVUho2HZuvTSrmfKnlvVY9odV149QuUedlQz5X1reAt3+5+C3z7ZyYrRD6X2Cje40u+332rdDz/U9TJHwsdlMM;25:DIfuyGDGpJ71BcrN0VBScxFcJuAxA9dPeg0BXBjuTyRAmL8LtFmTBEA9tP74w01ud35IkKUOI7lE9UPMw/TJ0mmR9XQ3c/KqioF1ecmnqvju1LJ4npFJTTgTIYyUjiSZclAbS+XLN9gHK0Dm+INClaw5dLMlllwKWSTo2JibhYSJ//KLV95YNMhe2uKNPPJyv4aKwAS9vh5wh/lHG/ETyaR7Poa5iFNoPRVsqfhLHoeHOBesFhmTKB80gcyy8ygFcUVZl5/p3mVJoTPe1TeKBu7uRbGJjdcELVDCVz+grnTZtqY+nIe6yz2kH4WxqUehIHoqUxOT6eX+eJ2cfHTVRw==;31:JL4xaOEWAAcCn8Hq3hx3sLJvOI/Bu6XM7ANk01wh1SRKyVpqmQGi6OQ7SxTaa0otrU0jRgqZ79rFsr32sNUddHkzIlEeSbQYb6bCcauknyqT/hBHXt57IZjfDG7T25z7AeCcjxPL3MCFRC70/znIDau629Tl8nLpq62KiEigx3Qf8XRf1NB9f1c+YaQIt1peqNS+DNhhGZej7lJi4uOM7oIJ4XMV/2zZk3tavf82BcA=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3215:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;20:82+JnSQUHIjmduXPYMzrBdDYf9f+Y3lASp4dWIOKmRZgOrQTGRcxKmg4/Oe4c1YNr/F01+kG9UvkEWhRqVEwXvjE0WY8O1aDIg7d/96QFYcd6iW6pStRiHjiIdNY95si1R1xsb++jYzRj7NM98V4A0EsP/EDyzOEXw1by6LyFRVYGPSQMswEYOxLqVA6jSFXhx8RwTjfpZZO1uJuHrY2j0oPTchbvPcUB13pPapCL2nuKTZ+cVf4rgra1arzMsMmR9yQ+ZKidDpwjogE/nhdT85THW98mNB9TfD0G7i5aj2sBEygNAo2EFgbxys+JPoiLUlk/oWDqJK7EGLtHI9hn1c82c7My101WhlKzgwS8c8RAZb+gJlegVxQF1lBHEBp/MALthJLQMdgtjjhvkn/yNx2wtyutv7mDc+186QAwCNazS8983QZsP+6NPWkayPB2M+vB2MJmyTMPh5NFP5ixUpI9waJkP4LI2TCSawC9KAtFcdtCJXgF7P7z451DNyt;4:V4yDn84aNZ91R7Qh8DUxWvXx6ru4WoDfNXwj7Eqics22cy+eyJCxe2cQLiATYbJHOqyfp04AgqpyOAhYNs9oXoZzFKJ/1wPQoCGH+1R16JRNZSx40n6ftpEttgtQwboh1D+dLX625J42UuT8gZwMhJezQ5Jgl1awSYKEgf8gH1QQ3sySrOWQPBB4I0pEPCJ+R4spZU1+w+bUWZowi0LfYNEqOWSJthsar2H/5Z4sNUYql+xLKFBPe+So6V2JXeEWn5YQ70sVEg8MPcRsnLq5CzZ+aKjMrimgBk0NhT8N0EyWNreIojt2yH9xlx7jNKSh
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3215FDDC68957BF5CC51002BE77E0@VI1PR0302MB3215.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3215;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3215;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(376002)(396003)(39860400002)(366004)(189003)(199004)(446003)(31696002)(476003)(8676002)(956004)(486006)(2616005)(25786009)(81166006)(86362001)(6116002)(11346002)(6666003)(39060400002)(80792005)(97736004)(3846002)(7736002)(31686004)(66066001)(65806001)(65956001)(8936002)(305945005)(65826007)(4326008)(5660300001)(478600001)(72206003)(81156014)(47776003)(6246003)(55236004)(316002)(50466002)(58126008)(77096007)(110136005)(7416002)(2486003)(67846002)(76176011)(52116002)(52146003)(23676004)(53936002)(26005)(386003)(53546011)(229853002)(105586002)(64126003)(2906002)(36756003)(16576012)(68736007)(106356001)(16526019)(186003)(2870700001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3215;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTU7MjM6dXBqTDRwbTJQUVRZUjRaL09FZ1FaS2hR?=
 =?utf-8?B?YTdvOEhSVnhZTGNkZC9jNlBpZWRCT2UwekU4bFZ0ajNTYlFQMnI5dW5pQnY2?=
 =?utf-8?B?UC9KSXhIYWRlV216STJsUWt0c3YxdlpkQVlRL1REYkthU0hWQkM0cmdNZUhH?=
 =?utf-8?B?MFQwTlhscitqV1liUVpvUXdmWkxjUlNpTEV6REpUZTNyWHdMRitvNnlvcXpH?=
 =?utf-8?B?T1JSMDd2TmVaK2w4dW80RFcxYkpoMGphQWFrY0tRcURlMlMzZXFUVUVydEth?=
 =?utf-8?B?TkpRYVpqYXFJRlBYdllXbWZkeVRUTExkNCtjaWpCZ25JM2EyMytjVkw0cS9D?=
 =?utf-8?B?MFQrRlZ1cW55VjJ4dHV0Q1cyZTEzREpodGFhUUtLQXhWa3djb3h1SkVFbnZ0?=
 =?utf-8?B?TDl4azZEcGN0eDk0ZVEwUEhvMmRCSlFBVVRaSkFkWWpKS3gvRWtXT3VzTUFi?=
 =?utf-8?B?ay9ETTZJRFU2S3IvQ1BEcjZsaUV0RWNUNkZiUkl4LyszZDg3VnNKM3ZlS2lB?=
 =?utf-8?B?T3J2bXdvU2w5VFdLTkFJaVVwQXcyTnFyNzJyRUJKbFU2NHpFeTZZZEF4eDZF?=
 =?utf-8?B?RXgrcllFU3hRVjFXbzExdlR2Ti9WTTR2K05KOEZaWWpZdTZ2cE5HVWZML1VV?=
 =?utf-8?B?SGprNy90SWZ2Nk13S011Wm1jNW9UYTMvY3R1Z3lreVVsTVJMSVowbWhGQTVU?=
 =?utf-8?B?eHYwcGtTb1RYVUNnSnNoYk9JcjhkMjBuMWlQNWtwNkFOSDNadUpNUzZGZXJI?=
 =?utf-8?B?WGJyME40dGRIVnNJQVZNRzZadkxOSHNQWGlkWi8zSUZsNDF1SWZFZldla21O?=
 =?utf-8?B?cWxVWlR1UWVUR3RwTTJtSzVKNTBDTDBmSFVQQ0JJcEhuY3dZc0Yzcnl5eUNS?=
 =?utf-8?B?NStoZkVIK2daeEZHbG9WWFJ5RjRUWkhsZ3JLUmgxZFlzNzEyWFNvdDF4bnh2?=
 =?utf-8?B?dUpzTk9zN2ljZ3RKcmY3b1NCdUZHVmx5blVzcjBDTTMydFVLV1VBRGpTaklQ?=
 =?utf-8?B?YjlGZW5ZU0tuQ1lBQjNUZlF3dDVVRkhzSzFkbHZtbkY0YThtb2JZM0dRMmNU?=
 =?utf-8?B?ZnV5YlExeEs1bVVIeU9VNUVXZ05NWkYvbDhOZ0trckhrRTd6N0JDaVFWOHZG?=
 =?utf-8?B?TEhQWnYxQXNoaDBsZjJhYlRhN09IeFUrNmE0R3U5ZFdnTTZxeDdCWnVuRGZB?=
 =?utf-8?B?Q0VkSXdrakZVZ3JzMWk1N0tCeG10VkNudjMyeXpleG0vY3grN0ltRXg0WHBq?=
 =?utf-8?B?ZVpmVVd3NWV5Z25udmV3bjJ4QjRRb2UwNWdaa1l6eXRoWWhRaHh2UWJtb001?=
 =?utf-8?B?dStrbk1WZzdmV25vV1AwdGhDQmVSRlFtSTZPM1c4NzZyaTVqM005angzSDBq?=
 =?utf-8?B?ek1vNUJxd1BjMTJpYWZvdmpZU0x2RFprVDJKMzhyU2pDb0JKSHQxN1JmZ3VV?=
 =?utf-8?B?YWozcXBHUjVpV2xhNUlYOUhsR0wyWDFYWk1uME9aanVCdHVsUStYQ0ZkUlF4?=
 =?utf-8?B?WjFyK0h1YnRENXc5eWJyL2pBR3kzSmNPdnRNMmVKeWJvTVZVejdXVkxQdWtK?=
 =?utf-8?B?NUU3SlZEK3BnVWRua3RPMWpxclh4Q0NqcXRiTFNrSXNHWVVLMWxhVTVXNXV0?=
 =?utf-8?B?UkVPZVNKR2VVWVgwMWFDekg2N3F6b3NBemY3M2RDcmV2N1pZYnRRb01MM0I4?=
 =?utf-8?B?NGt2MzN4K28rM3h0ZWhSTmRBbXJRU3BRcFZzSHJzMjFKNHhiVXVMWVhkQVk1?=
 =?utf-8?B?UjlQRkYvNExPeiswQ2diSWJURWROZXRseXByK1J4V05EeFVXZ0pMNWxDQTdj?=
 =?utf-8?B?aTlVYUpmbUowUFBXSXN6QytXSEt3VHloZ1FVYkQwK2wveXcxaWorTkFkd2VT?=
 =?utf-8?B?ei9UUXFWWGtDNC80eTZuS0gyUDZ2cHBrdFhUdzNXd1pvdTcxaEhtU0RZTWsw?=
 =?utf-8?B?WlByRi9uSWxYWStYSTBrUTMrTnZBRmFDMC9TWmFEMXVaMVE4b2YrMGFsbkhT?=
 =?utf-8?B?djB5MDVxcjhYb0lzeHJJMGM0NStwM3Zoa2FYK05abFoza0tsZmU1YjJvWGtJ?=
 =?utf-8?B?OVhPZlYxbTE4UmhkQ2NPcCtheWVTM3JTekpCYmNvUXA0Q2lhQzdjeVdXaE1I?=
 =?utf-8?B?Z04rdz09?=
X-Microsoft-Antispam-Message-Info: bC0a8Wxn4YN5BGVpFAkzTc4lUv46WXPiGzd+mxhJTPid9rBoKU3yRUQ9uEDYRZZReH6JoPuRt/lNHbSL1ZY6ehpVjTaTHPa9zq8rJEA8nlYldrU2HvIiN/PI3vslehGLvqvurlRS7KpngnUvC1cZLlB4aLXWjQd0OWS4O1IBSAtEmGbtdj8id3Aj3qRwv0Iu
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;6:9BBSCWyG7w3oRQBSGoXyNcXfDfcU6aDIrgFE+nxOQ/m2Mmba43XfJvEECHerO/JdplVusXPm49JZqsiLHvdTmm1hLqrU54gs0Pk6znsz7JSS71WotzotvH1pvvoMFrPpjO7BITg1m5LWDoYOfhFBRKSr2ELdXw6tj9ShaHVeeIc3P5uKKRPPyuBnG1rfftLmGA8KUwxsswDXPhnFM2+YsCMwRZXaYVHL0Dpua3KG/f/mEVcyJ0WnEd36Q2pMJxymQ8gzkNjCn18lLto5BdVSlOksBRWBUrLa+dOZ6oSPVnZtFaM6zHgYByRImlTPqZCnr1qPtbWTc3Hr4ymfcPCOrq37HDrTv5OlutuNS7ItpXmUf4ojiDuwmll3NhD4TPLG+WnNd+tV1NaklT6vUseQvrCD1hQQ69raoPxHbOK5Yafg0L0y5wmJvYCD27ucRPWZ5ChKkojO0zSH5cEt4MeTCA==;5:UDQhSnjy0RI9Rg0Y0L2rVom6ldNCE10MDdx2UCExe256W58HMNw2bkZQE+DJER2+eGfU3VSuZE9K+vtsYZDQnFfEVAyLWEz+u606N3PbRtKTd+o1sEvaRpZ1eCIhpiqOMIR6Lgx6I6HB4BK6RzXGiJKgt8YOAhhkOPZ8xJ+sTJI=;24:BX2u2/+4R9aYjkCQqbC1eFkBHDn+U6vLMH2BxdzSIvWrvOd05od5lmriR8M7X8AMkdMdMgQTT2ACPnbR3odl7wxeQ8T0xBgg5eWJh07qV+s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;7:XrV40fX7I8OufzKxQnOareGn23y11HRZGvmBo0r2X5NRWH4gUrpKDTTMONkxg6Cw6uqhc2zBbW67ca7f/lpqG0uxm7qo6qXUWUPOca6O6XZF39skJYZ8symzEyCTsGDoVUUHpAKKv+SolsI5q1ie1FTpu6AyQTHYwN4X/4fP26z0ScAyhVzvLLa4LZqEuNaXssyHUyvkXAWcb7ubeyEUfjk9OHBbeV5DwvfPRcv+oDQzM7VtO9zgWnRouYS7hRBX
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 07:16:10.1277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6718ceb9-cb45-487d-2e2d-08d5d0fd8a65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 04:26 AM, Boris Ostrovsky wrote:
>
>
> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>
>>     static void gntdev_print_maps(struct gntdev_priv *priv,
>> @@ -121,8 +146,27 @@ static void gntdev_free_map(struct grant_map *map)
>>       if (map == NULL)
>>           return;
>>   +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>> +    if (map->dma_vaddr) {
>> +        struct gnttab_dma_alloc_args args;
>> +
>> +        args.dev = map->dma_dev;
>> +        args.coherent = map->dma_flags & GNTDEV_DMA_FLAG_COHERENT;
>
>
> args.coherent = !!(map->dma_flags & GNTDEV_DMA_FLAG_COHERENT);
>
Will fix
>
>> +        args.nr_pages = map->count;
>> +        args.pages = map->pages;
>> +        args.frames = map->frames;
>> +        args.vaddr = map->dma_vaddr;
>> +        args.dev_bus_addr = map->dma_bus_addr;
>> +
>> +        gnttab_dma_free_pages(&args);
>> +    } else
>> +#endif
>>       if (map->pages)
>>           gnttab_free_pages(map->count, map->pages);
>> +
>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>> +    kfree(map->frames);
>> +#endif
>>       kfree(map->pages);
>>       kfree(map->grants);
>>       kfree(map->map_ops);
>> @@ -132,7 +176,8 @@ static void gntdev_free_map(struct grant_map *map)
>>       kfree(map);
>>   }
>>   -static struct grant_map *gntdev_alloc_map(struct gntdev_priv 
>> *priv, int count)
>> +static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv, 
>> int count,
>> +                      int dma_flags)
>>   {
>>       struct grant_map *add;
>>       int i;
>> @@ -155,6 +200,37 @@ static struct grant_map *gntdev_alloc_map(struct 
>> gntdev_priv *priv, int count)
>>           NULL == add->pages)
>>           goto err;
>>   +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>> +    add->dma_flags = dma_flags;
>> +
>> +    /*
>> +     * Check if this mapping is requested to be backed
>> +     * by a DMA buffer.
>> +     */
>> +    if (dma_flags & (GNTDEV_DMA_FLAG_WC | GNTDEV_DMA_FLAG_COHERENT)) {
>> +        struct gnttab_dma_alloc_args args;
>> +
>> +        add->frames = kcalloc(count, sizeof(add->frames[0]),
>> +                      GFP_KERNEL);
>> +        if (!add->frames)
>> +            goto err;
>> +
>> +        /* Remember the device, so we can free DMA memory. */
>> +        add->dma_dev = priv->dma_dev;
>> +
>> +        args.dev = priv->dma_dev;
>> +        args.coherent = dma_flags & GNTDEV_DMA_FLAG_COHERENT;
>
>
> And again here.
>
Will fix
>
>> +        args.nr_pages = count;
>> +        args.pages = add->pages;
>> +        args.frames = add->frames;
>> +
>> +        if (gnttab_dma_alloc_pages(&args))
>> +            goto err;
>> +
>> +        add->dma_vaddr = args.vaddr;
>> +        add->dma_bus_addr = args.dev_bus_addr;
>> +    } else
>> +#endif
>>       if (gnttab_alloc_pages(count, add->pages))
>>           goto err;
>>   @@ -325,6 +401,14 @@ static int map_grant_pages(struct grant_map *map)
>>           map->unmap_ops[i].handle = map->map_ops[i].handle;
>>           if (use_ptemod)
>>               map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>> +        else if (map->dma_vaddr) {
>> +            unsigned long mfn;
>
>
> This should be called bfn now.
>
Of course
>
>> +
>> +            mfn = pfn_to_bfn(page_to_pfn(map->pages[i]));
>> +            map->unmap_ops[i].dev_bus_addr = __pfn_to_phys(mfn);
>> +        }
>> +#endif
>>       }
>>       return err;
>>   }
>> @@ -548,6 +632,17 @@ static int gntdev_open(struct inode *inode, 
>> struct file *flip)
>>       }
>>         flip->private_data = priv;
>> +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
>> +    priv->dma_dev = gntdev_miscdev.this_device;
>> +
>> +    /*
>> +     * The device is not spawn from a device tree, so 
>> arch_setup_dma_ops
>> +     * is not called, thus leaving the device with dummy DMA ops.
>> +     * Fix this call of_dma_configure() with a NULL node to set
>
>
> "Fix this by calling ..." I think.
>
Will fix
>
>> +     * default DMA ops.
>> +     */
>> +    of_dma_configure(priv->dma_dev, NULL);
>> +#endif
>>       pr_debug("priv %p\n", priv);
>>         return 0;
>
>
> With those fixed,
>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Thank you,
Oleksandr
