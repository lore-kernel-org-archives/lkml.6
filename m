Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9B2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L97jqp/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E9B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeGYKLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:11:15 -0400
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:47904
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728222AbeGYKLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eemJZhPseyrOkkdJbKGT8EIzZ5osUBUrpYMEsHmh9pA=;
 b=L97jqp/wAZKLMtnuU2axZwy5RW3bF8UjcGGfaD9L0RAQVHxw60VW3Na3jYY7eRIb6ZxFmMhX88gzJXSIK7BlcrZNETRqH186IIQU1qdk02iO3aqfxds94T18tXEPncDQCGy7ZLn+xTWHEIHHve5yKsAmZKsD0E+wepRRi7YY7UU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.136.129.116] (202.56.249.162) by
 DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Wed, 25 Jul 2018 09:00:23 +0000
Subject: Re: [PATCH] ASoC: AMD: Add a fix voltage regulator for DA7219 and
 ADAU7002
To:     Mark Brown <broonie@kernel.org>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dylan Reid <dgreid@chromium.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
 <20180720121816.GD10784@sirena.org.uk>
 <50343cff-bad4-7677-851f-f0b818ae7b29@amd.com>
 <20180724171428.GQ13268@sirena.org.uk>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <343d6aa1-0687-a6d3-fb1a-3f1365db1e6a@amd.com>
Date:   Wed, 25 Jul 2018 14:30:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724171428.GQ13268@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BMXPR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::22) To DM5PR12MB2357.namprd12.prod.outlook.com
 (2603:10b6:4:b4::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a0f155-c53a-4d48-2bcb-08d5f20d10bd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2357;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;3:LuhzLLxahmeuwcuYkGJ8tKdn3OYZ6IRKpUA9J9f9fOfkJRCwXm2IQsOoPML4/pHehTxjjgW/7HSeXNfrrpqePdbZgUR7TdDj9brVwZQGPLt3qAzjH9kN69UvRSRqIaXmO19t4gm4z6HAw4GkK06nPfGFwYUhDztcCzT1jtRYDdnQr8YxUJ4XkIRr9aMSoM2y7xzOWXNMRY3l64a4R5I2kmzlkr3MC75c58fmOzd7kHW9lHQkeBjT/QEXWS8xu2pt;25:vuPgYzrlrpn4BTdwaYz2ooGNnv4M+XBVeMPpyktkn/B6tuoa8sRu4PiFq7vvnh2qvpE1Txzo2cCum11VX4NluLkc1Hi4Lenccr40hFmqvdS0ITaggZUzrXgXPnnJzMmk4ODRxafaMNj/O3tJ5Td5clNxU8hBlaIQlROhj1NpqP7KT+He1eS26l5uTGpmUGXcL7SJkeaJM+4I7Hh3tdXa7S0n7a0Nda+otCdxmnJSLrYvYluFo13WPOIfjwogErBOPOmbyKDZheDfDRGMRrvvn8hdVExwzUKP+K5BYs3Ed0P466NjVJSQimykwWCDtCdqVnNjRcFPD+a+7oYcxdX6cQ==;31:TbC4OA+Ma/ofm0123fZjckzoKzFN+rbJ1q1oh3HJmnTHcf54X6O33pXtQDS9uJa3kAebr42i+CYY+A8wxZAXx1jQ3PmDWQqeQ+9fTXl+QH7WGWdmN6DS0G0nJGxTzbTMnt5lCVWk3k2hFYDSpPWNXDiuuSTGkhxe0d6QVKci0ojG4c2puqOl4zS9NJgDmmQl55LHRCJaV1KzeTHMnDcKEum36S/pV5r4PxfE+Eo5Lu8=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2357:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;20:yhAI967mJeA6JbFdzFdSj6XQm1xzbhfL4sKSwgZlqcbBaBe1Wo+153FlSFlFt7WOpDEdgWWnbv2umnQVAZY3LHHrqJiRbeYwQhcg/I0tBjz+oZC9m4qWQekJGaa2//Ucgrp1cCbQT+35eCo6KKfIxCcYy594w7DJig3AVVHgvq4YWAXYsy1u1F2nE+tvu4p6bzke15YpNJdYrfRpuvhFlkmHauQ19MmmkwY/+zPTjekrm7FSzDmFd5Nw+gP97M8h95BIz9hRil/tZ4sVpXo68ng3vualgJzRA0A1ToD1qhBHVayH9I/fd4XDWiqPGf0oesPCDSpgo5Q0sqBKk1F0wu5j8tQ5ErXCIiyzkGtso4bXC82RYV/zXHxhawZT05VMbQ3oYA4uWTIQUV05Isml2HYCyNEjaYcrFBcbNP030aqJrO5yaUxI2qLv+I+z2amsm+3gjpTdvu8V/Td+YlGEnO/Wh+3oDUYaCtFoE7zZCH5s/NZo2R7niJZysOeg94es;4:5ZeWVD8yx/0BQnRH/UGDs3wfItbfHAjHIOt7N6YVQF3lJutD6K8wztyfsLjcdTvd3qeKAUxg+9EHTTeX6W04a5rEofaWTjbODnY7M+YSsBnRRqfeDRpcXfLV/kucI1apn+VZC2v8ij/jgCmQ7p28f2vnDDrVJReBQXOFlWsCv75VxJRkpUzxht6CDKvigFMwyRnruw0R6Y1RYcs000p1kTo4AFy02Byn03XH4obiTKEPSFrzt6zllKEsaJLNuX6Py4l+ZTzzvbdwm0KNPLArtQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB23575B2B91B9809116178860F8540@DM5PR12MB2357.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2357;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2357;
X-Forefront-PRVS: 0744CFB5E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(2870700001)(66066001)(446003)(26005)(11346002)(47776003)(68736007)(65956001)(3260700006)(25786009)(39060400002)(476003)(2616005)(956004)(7416002)(16526019)(186003)(305945005)(65806001)(52116002)(77096007)(8676002)(2906002)(7736002)(64126003)(50466002)(53546011)(6246003)(76176011)(81156014)(386003)(81166006)(4326008)(86362001)(486006)(3846002)(31696002)(106356001)(93886005)(229853002)(6116002)(31686004)(72206003)(23676004)(2486003)(52146003)(36756003)(6666003)(105586002)(6486002)(6916009)(58126008)(5660300001)(97736004)(478600001)(54906003)(16576012)(316002)(65826007)(53936002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2357;H:[10.136.129.116];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzU3OzIzOkFrWlVOUS8yOGI3MnRMZDBRYVRtV1BUZUNj?=
 =?utf-8?B?SWN2RDd0UFpiVEliZmZtNnNRYzB1OUhmaHljL3kzUzFHNTR5V0ZDR0YzN29T?=
 =?utf-8?B?OGtzbzk3aDNVS3lwNzFMYUhrNEhITHcwUmsrZGJKNi9lRit4NDNOTnVLaFVL?=
 =?utf-8?B?K0NGanlFOTVZaTBrS1JaQUZuU2wwNHpMMmwrUktHRWozdTFYQk9rbi91S01J?=
 =?utf-8?B?b3B4YkNqWHc5dGxTWTl6SUpHdUIyNExLcjh3VTB6NHJQRUxtRUVFTjNDdHgr?=
 =?utf-8?B?Q1hVam5lU2ljK25hK05xRHZQbkFxV05FWG5rK29Wa3B4TUdLOFJsZkdIY1A2?=
 =?utf-8?B?VGh5emxhaEkxQjhsZHJHMm9uZ2lqSzVoR0U1WENzQjZiaW5lVHZkeDU3MS9l?=
 =?utf-8?B?RittZThsR1R0c2VyVjZEQTA5OWRHSDZlUFRTUHBvWHZnUEI0NWlzQnFmYzVB?=
 =?utf-8?B?Y3pUalFzbnZCcE04UUlaaGd5Um5FSlBmMU9iaC93enZnQlZ2bEZOeENXTlpu?=
 =?utf-8?B?WVBUV1Z3clZVNHNicVQ3SWNOOXdpUG9MbzNkZzByS1ZzQ1M5bCtiQUpFamRr?=
 =?utf-8?B?RlRDblBVQUNIblQ0R0pZU0RKalpwbnltL2Z3bHhpeUtkaTdYRzUvbE1kSm56?=
 =?utf-8?B?NHZxNTBtaDY4d2w1ZVNrVzFVcDA4YzVodnlsNUtncFQ0V202MHRkMDBYQW5w?=
 =?utf-8?B?NWdrMW03UkEzMmdtTUMwTFRSSzNZenRQbUU4WFJnenZyWU5RMlhjQmpEc3U2?=
 =?utf-8?B?dXJoUEdsNURUMnhEeFpVbllNNUVoVnJHMGg3NjJGNzhmdjI4TW4vYTdDcnoy?=
 =?utf-8?B?amFidXVWTmZhQkpiZjhtL3NOWkxJMm0wSFd0NTY2STdlMzd5azVsSzNlVGpa?=
 =?utf-8?B?R2hwWWNyd2hHaVk3UFMreWJOVmdvUUtmbWxjTjZVTmtCNnFrTEM4anhkbkxK?=
 =?utf-8?B?LzJtTnU5MDNOVmRkME1hRnV1UGxtRWE4RFNuNmZrTldoZ3FjUUxpemJKd2tp?=
 =?utf-8?B?UWtyWjM5RHhFb2lySURRTmNUNlBvZ1ovUGt5ZWxLL3VueCttSU1Ba2l6NENK?=
 =?utf-8?B?YlpuYStBUXJWRUE3S0J4TzNSNWp2L3J6M2xUZk5iNTFlenhQeHpEazJVMXdC?=
 =?utf-8?B?aGZoNnhPN0RBd2E1dG9hUUpVYTFoT1lPNnFKeEtiNmI4bEFhQkcxc1dyVE5D?=
 =?utf-8?B?S040QXByVEIxSU16TW03WjhPN3ZMbmpqM0VUeDlOYzAwRzUvM3RmNHhZNFdp?=
 =?utf-8?B?VHFwdnpwWGhSUENpUTZPb0ZjYWMrWkFUaUZXR1plVjI3QWZjZkE4WjluVjNS?=
 =?utf-8?B?TzhCUXFUdk5SUVp3Q1RadTlCQnNSTUNvV1NKZCtmMTBBR2ZUbXA1Q0RwM2Q5?=
 =?utf-8?B?Y0Z1V21mekVWTXFpZWpZMm9BcGZIdnNnNVZtalFiRjdUVDJEbmJmd1VyTU9r?=
 =?utf-8?B?V3dSMStxZDFIMTBpZkVERFhlZCtScnB3SU1wZUFsNVdmaTFFTUNPNDlkTGxH?=
 =?utf-8?B?TVgya3JxeWFVOXBZcklybDJpQVZHdmZiZ0prMG5lL0hpLzE3RjRvNEwwOCtH?=
 =?utf-8?B?SEhYZEVyMytqVlJPOEVqcms1b3hqeGRXdWdITEd2ZFNvR2hrYlVFNG5wTWp0?=
 =?utf-8?B?WFZxRHNNdjhNOTJaczlGTWlhcHJtbEtCVTZ5aGNkQXp3ZUVSWTViMnNSUTE1?=
 =?utf-8?B?NElvTUtGd3NJeGo0TVlPVGR1T01na25xRFBpUk9aa21vVFRncnljMFR6eUFx?=
 =?utf-8?B?bFRJN000S0tQd2luT05CQk45K1ZsSW5sVEp4cDJPQ0ROcElKaVFacjdIdHFD?=
 =?utf-8?B?QThuZ3kraFJ0U29NalpWd2pnSE5CVUIyYXh1RW5QRXFwZXl0ZEtJNUFkZnl4?=
 =?utf-8?B?SkVNVHlNbHh5STlVOStQVkNqd3BhTUhld2p0Y1gwU2F6U1EzL0lxelhwQXlF?=
 =?utf-8?B?THRjV1Q2N2VyYll3bjFLV1kzc2gvVkw5NWxFZlNkcDhucmVmYjhWaFVmNlB1?=
 =?utf-8?B?dW9yS1FRalY5NEYyNnlXRXp5bVFNamJ1YWNhQ2VTQTZRN01GMnVSUHIxTGh5?=
 =?utf-8?Q?4rpWfN6o1CueSnBrHkf1pYNd7?=
X-Microsoft-Antispam-Message-Info: wTmD2nOUG2P7hlo1PAmlMohlWEs1POyX66JSQZ1ehgb5YpTyiuSkPR7Qe4+ZBL9MBYrIZQaEfpB1fbIHVPPHDzMnwD4dX5o2XGH7oaP2eFXjUF3FWIk4UGBR5eahUiNbRphEv5E69akVpfI9faTPbBuS+59jPrJD5YJIauV4DnwUwB1MJQyVhkhbdXMM399d4ALGXhcCOdsWoYoeokkEvpVquScGyTEUjPc0CVw01doChGpubMLBLkH6QO+Ek26+SKDit0rU7UCF6FILwnQLhJsG84bIIco3qAGOeDvLlHSDAFbCRd+xAicSncAUxjZEAVsf1C88/ZtqA4AnL7htM+96TCg8Du8DJ9I0HGmg9e4=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;6:GAT+pjSk432JN9KruKeRBMeB47SwMagzyebB9V83ETurcrkjqshd9g+Qcx5KnxhNTxvGtYs1LI4kEyTkuQIWZhvDBdd+6u1qevW9C7KbcwQsp7XliT557IviSJ5/0t9hQVMMgdg0qFBo938TxH0rziNGQy/Z9iFNR6Ekh0U96KHS2WyhxmrzD/krNFoV0pyxgXq4GL1CFeZLLlkXF6FSzMEpjOgYmJTCrRk8H5obiNjQVtju3gtIpA2XdCgQLRnBtssLHAUMMTtPtcfL6V02G/YFGpy9eVA0kjkiSw3H5CpTI9FExzOBFUI0gceRMWptOv8A1bMLoNkZTD2Ivq26d4CJDqx8LFAjGbAayu65GtM9XHTGIYOdCagJ55XteUWjR/5yS7g9dbJfZmbRUX7/8b3UK/oKK1IybYIpOWjBkLEJhIml8goAUbFuAhiIqD5cbSKLNFWXHABTZVzudFyTWw==;5:opvoKBDX6SsDngNz3lqp49lvQUp3dUPpfEpvOowd9UtpYk+pDHN9MWAnms85Nq0bqwONfYGGf1qGePA9NiJBXRdX2Ms/VzboaEScGAj+2fnDh7iBREkWCafsvUsBzvx57Z63n/+xwZpeIJJFvoZB8abOHeg9ld3quZ0AObwx244=;7:wi4HLQ/sbT+b9NPoSeEOjB3M+EJpcmtfc+coP/cwDChK1f48VGt9+XkZIMYeu7iRHhA8Rc8dui31gwqzHITqPnmNN1PspyDnqBVdouOHyiysjOZnTLye2XBcUfJZkvwV4xZzsu0EDjeDWjtYsso0K32ZNVGQDrXGObynM9rL262pgwwDmkRKRLwzrPV1CErnMenV2TfLuJy4DTb5RbZtQC+0iuwJiXVEh69PORp4UfBbD96S2JuOwKcVQoG/DmEI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;20:3Va/DepwdRijEf2k+ff4Qe8EVMEbPKHA4iRoFRpMQZ3D0gJt5MlKitgzlE01FRmBbR6vkFKcGsKKdrCfx5kATxBs9u2ShuLWaUmidgPZSPDM8uWllTGa5XMbmSNWGueUGdC6oYnBf7FpDSUuBwDX3vfFNrBKur6UVUj7ZOI0pspvLx6gKxyG02DZqt++UOMIgDVlT0YvaDafUgpqYUSmoUfhkzWB6bKvUS7+dMv3A2MCPM8hHVpFcKYOKJYp7agf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 09:00:23.4934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a0f155-c53a-4d48-2bcb-08d5f20d10bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2018 10:44 PM, Mark Brown wrote:
> On Mon, Jul 23, 2018 at 10:56:44AM +0530, Agrawal, Akshu wrote:
> 
>> This approach shows inconsistencies and in some boot cycles da7219 fails
>> to get regulator. Form the logs (below) it shows time gap between the
>> time we call “platform_device_register(&acp_da7219_regulator);” and when
>> the regulator actually gets registered.
> 
> This hack isn't going to help with that AFAICT, you're still registering
> a platform device and relying on it appearing in time?  It just
> registers less often.

Yes, I agree and by "this approach" I also meant registering platform
device and waiting for its probe to happen.

Instead of adding a platform device to the reg-fixed-voltage, we can
register a regulator and thus not wait for the probe to occur.
Pushing a v2 with this change which has consistent behavior.

Thanks,
Akshu
