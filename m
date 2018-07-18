Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5E7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE90220684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LUVDtS1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE90220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGROQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:16:36 -0400
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:24635
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeGROQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xQtwqz28lL9bRFBgCkav7hM31R8nc9U/EocE5BTj2w=;
 b=LUVDtS1sIrOwt/EUIzk021bEwCcXq+d903Kda2e0siYAr1DS8C6UoIZVluYUUT8YLfoqHJfaOzZI2dyq0qB9Uzej71YuZgV19gedg2UlfilbytgR8YS7VgF0FzKOTeDoGP2d4UUvtNtLvBI4g5nQYAa4pUaJkrXGmFQNxhqWX58=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [10.0.6.130] (173.243.43.210) by
 HE1PR05MB4649.eurprd05.prod.outlook.com (2603:10a6:7:99::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 18 Jul 2018 13:38:24 +0000
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
From:   Tal Gilboa <talgi@mellanox.com>
Message-ID: <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
Date:   Wed, 18 Jul 2018 09:38:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.243.43.210]
X-ClientProxiedBy: YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::41) To HE1PR05MB4649.eurprd05.prod.outlook.com
 (2603:10a6:7:99::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d761e79b-f994-49b6-20d7-08d5ecb3be7f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4649;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4649;3:EUsKSOnfVvR+MAAqoWt570l1Ov6+thgDMdMS9hxdfgMXIhOXth0ZoairIW8nTzAYeZY9dA/4azTqpHhSC9Rb3WjUhe+fEua82kKYLBxD8PjoSzPPHZV8/WCb5kOHnH3FdoJKjd0vpcCD4WELwccisselwazFlBWTkYmMiOx6IXcoB1HIyZPctPsQndTqYhmeg6zz4Gq/MFyAVARAHggXdByXYnsqoMAl1rNBGVOW5dXMpmkTomD44Yeh7djzjHE4;25:3+oKQHy3bRhnwesTSc0J6W6wWRVi5BodtgXDS2Jxhj5GI8nIthXfpYQAhSB4JGMrushR2c9JzY7jueaSiMnrgy1aIuL2h+4e2qpg/3hLTmDjquOlfpuJXUOTHItnvmUrkGX3JGjaj+7WEffL5L035x998tq7rWkURZG31HB7Z3rvvYPQsUOXspd7prRwCrQSOqc3rkq2XQ69le0AUFmJhSUnxP4Ohh8WtIkZgZEjjKIZddVYjTyS+TwXFb8so7R4I/G3Utn4QwMjJRT0PlcP1LO9X23YgWEGgra0vCkm4TQY8zVUVBSCgJz60Il+DlCuxDUA6VzNNCuFkg2k5T4MNg==;31:STr+3UO8SjvjotNgNR06x9b9rtEipjzDGRo06JhCcJysdH0jkQiKm6pUoxIphZT3skI0+eeLm4EH1ZnAaZEzaY3gPNspzj+SARBnSuuJoEKi9g1fTxidRr8Yb1aQF7VHXWlJ19CakUGByfaJ2AxAEfP3FCiDua0zIBz72md2kSLKI5j74v6xpmj+p7G1XdUD4mZzBJSljzb13wIsLL2yd3ycA7leA/EWThvqJhZygU4=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4649:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4649;20:QZoIFxhyxUQG4TIOu6cmuYHi4u5vslEM1kYRH60pP6s9xQ9cX26g06QhlPw8gh2B8m9Zj2nH0aNIjGqQD+op9PA0xSEXBSyQx10J2Yp5m6cys80CvohyfQYGkH+ct5QCX65AeTH3fCBkkT5MSK8il2ATkqeo3m1F6V6vqLb9yBnbRQCv4QPGZAzlr44vvMwHYoWD4dB9TLAsgr2nqcPU9jyN9KN8UxsaBUFWRuI0UO2h8fEKW4HUAXqGqw4YjccQDhmSat8EA25uywVnUI7G8kyeilEPq5FcdngUB1cIf69YC882pX7TCSeHMclgJiNew5ZrOxtrKBWhQUCR+Uu9e31JxRAhTH9y89zb/zUNZgKTuxFO7ndzhcFxKPyyJZQdtd6WDbhg0J97GD7Yx2JxshMraQpc1+S0bMX2nXRcfIVawMhJCGPhAyFHQqnBdtGIuNvFLO5CBgybbzUSjwcSpGRHmhCv7Q37bFykG3Of9HqDfaXszAZZfltN6FOkURPI;4:aQ527PIIETayGd+gRijXy4FPB2jzdIyVLBkKLjA6T+WSYGTSZJqvbwi3wBxe0c56GEE9w6GDU9NUk2b/foN3w+ZqCVZt2xxIr6zKH/xIIdvkJHhO1jeBJA4nFcpoQr3hAeS0TPTdXyGfK+yxMgjrPEQp4NGqekuciY4knuCgckxQlFnWo19FzAvgOjVur3cvzBeHUQcj12apDrWxf5vbku5sBudT8ypa7B0T5zcDcK4CKGpkmm/LWjvTfyZbJZOoDUuZhprSVXNTj6ZY8k7aaHjUtW1Oa5YN/NrWOAfVmPyZBlYOBS7TUe08xg2Gu5/n30xYHpa9vIFwRIS+PjcQ7FbKQMaadttd91UTU7sSdT8=
X-Microsoft-Antispam-PRVS: <HE1PR05MB464962B802CC38ADA22BBDCFD2530@HE1PR05MB4649.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB4649;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4649;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(3846002)(36756003)(316002)(6116002)(16576012)(2906002)(11346002)(14444005)(2616005)(67846002)(110136005)(229853002)(31696002)(6486002)(65956001)(65806001)(66066001)(47776003)(575784001)(486006)(8936002)(446003)(86362001)(956004)(476003)(53936002)(54906003)(386003)(7416002)(7736002)(305945005)(77096007)(26005)(31686004)(6246003)(53546011)(81166006)(68736007)(50466002)(97736004)(8676002)(81156014)(76176011)(58126008)(64126003)(5660300001)(4326008)(52116002)(105586002)(65826007)(230700001)(25786009)(39060400002)(23676004)(478600001)(16526019)(3260700006)(186003)(52146003)(2486003)(106356001)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4649;H:[10.0.6.130];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUI0NjQ5OzIzOnVmZytWZ3luOXRQaU1PTCtqMU1GejQyWWxG?=
 =?utf-8?B?emIrTDRxRWQzRHVHMDRSVWN2bFNZNzJvYmN5V1JVOUIvQ0Z3YmE4c0pTTWRn?=
 =?utf-8?B?ZGtjNVk4MytUY3VTcHNQd1gzOUd4ZXNZWTJtYUxIVHdHNm82WVhHY1l1bTJw?=
 =?utf-8?B?amt5ZWxUVEtWUFRQZ3FzRUdxK0Fna0RFNVlGU1o1M0xXQkxsWk5iVGxFeXJz?=
 =?utf-8?B?aVFQWW0xTE9vVkVCdllmbG45YW9MMVNCYk9HT1NGNTJXR1RZWVhEc2Zpd2Z5?=
 =?utf-8?B?OWJFbGxQbStCTUFSTEpUSkZiOFNFdEs3ZDA5VDVyazdSaTNoUUxQdjBkWnoy?=
 =?utf-8?B?dUdXVUk4bEZSNnpRb2k2emxPZ0VFMXpuSkRFNjM0ZCs3M2dSc3g5K25WYkxz?=
 =?utf-8?B?cjMwSzdaUjdRVkNEOEFycEpiWms0WEFyYkhyUHVxRFNMdFhIdVNkaVUwZzNJ?=
 =?utf-8?B?OTdyeTQyTjlHb0dkZkI1dGNQYThtOVg2bGtSUTMveDZGZks5OFVGTXpreXdW?=
 =?utf-8?B?UmI3cmQ3d0d2cml2WjQxR000TTVtbnZXOVZETmJLRmFuMEpBNm1VWTBUM20z?=
 =?utf-8?B?aFh3NzFhQVlZUFd6Z0Yrbkt1a0ZvNkpjTTN0aFA0S3pUc0oySndBUkFOaUc3?=
 =?utf-8?B?NUJoQkJQa2xTL2VDdFpPU3R5TWZnRzN6WmlucWNpaUNrdUJKMVZUbDFQMUZk?=
 =?utf-8?B?TEFiZGR5K1BaY05zZjdlSHBodlI0MThvTUpPdjZ4RzE5RHR6UVpVZ3dmZ2JE?=
 =?utf-8?B?WS9ydGVVditHcXN5OTR3aWlYemNvSU4rWVRqa1JpQlk2emlUNng2SG1iQUI4?=
 =?utf-8?B?WTBHOUpnR2JNZGlFb2x3L1VWRWprd3B6WElXTnZIamxEVmVleUk3QUxsRWJy?=
 =?utf-8?B?bHozVCtPekZza0VtSUtWMmg4NEhQNHNSbEZKWEE2YVhEWnpyY1kwaWpNdytk?=
 =?utf-8?B?UEx6Mm5ySHRqVDlyZVBISm1FdWtxUzBUQ1ArOHZiRTNpQ0RZMlBiWUlKTDZh?=
 =?utf-8?B?NEpIR3NEUE0rQTRrTUY2U1NSVitxVnNlMUgyS0g5L2oyei9GN1I3WDhESU9K?=
 =?utf-8?B?Vit3eDRORHF5NGppUmpjR0FpV2pTNDE5K3E3NGZueWpkM3Q2OVJIRjc0VG9Z?=
 =?utf-8?B?OXFmaWQwK1hOZWNxT2FleU40MHo2ZWZmaGszVkJXdEMwWndSWjgrZCtMblRM?=
 =?utf-8?B?c2w0TzBqNEJNY3pYeGNIRHpGUmI1SCsxcWtmQStiOFVXcituaVJpOXdUTTFy?=
 =?utf-8?B?eVoyR2RGWXNmNCtpUFduNTlGc0dkNUhUejI2dzNGM0p6RUtvV2xjZ044NC80?=
 =?utf-8?B?TVE4cDcxT1ZnenV1RnY1S0VwOTJwNTdaS0RkbVA4V3NOSEh0MUMrem9nRm4v?=
 =?utf-8?B?NU1aQkorRW00Q0FPTVo4Q24vZUdHTUxOZTA1S2VnRTEzL3RaQUFTMFBaWDBK?=
 =?utf-8?B?Vk5qdVhkTExQK0xHcVh0MlU2RURFL01lOXFMUUd3ODZHZXBPZHArbEVtNm5Q?=
 =?utf-8?B?UmhlRk1CZXA2d21rcDdnUUZRaENvSklpckZqYVRlTGJoUnpUWjk2dGcyT1dJ?=
 =?utf-8?B?eHRoRnUxdDNZc2l4cDgrYTFZTkswVXNHbS9oZFJkZlVoQzQ3c1RySTdNcWFo?=
 =?utf-8?B?QUpxY3pESlVUWGl0MDFJYm03SjVKSkRuQW8wcFVJUUtYRFYrdmdDQi9xRnFh?=
 =?utf-8?B?SUpCZkY2TEx6VkQvK2NUMU9jVzdEMXVWNSt5TlA4YWdxZVh2WHU4a1pocWt0?=
 =?utf-8?B?MmxCc2EzclJjUnp2T2xYd1NXK2Zrbmd6THdHcGEyeDIrcmRnNWVJMXF6NkNT?=
 =?utf-8?B?TWJWZEN1aWpzN1ZVQVhQbjJHY3BkRTJTdDJReEphb3JpaWhrNklDU21pdGxk?=
 =?utf-8?B?RVFVRVlIOHQwWkRYYVpKQjU4aW5SRVZUVGNqTXNnTlVOaHA1Z3YvMmV3Nm50?=
 =?utf-8?B?eTZKNFkrT2U4TUdwaGhuaHpFYlM2WUs0amQyQVJKalRuUjFSMTVWQWtXeXda?=
 =?utf-8?B?c3RHelZ5ejU0UDRFM3QzZHN2WC9MaW5hVkRrSWV3STlTbEtNU2xzSEZLcEhj?=
 =?utf-8?B?OWZSK082ZFhlVlhicXhDdVB0WlhoMHNVVkdEb3ZGL0pYY2tqL0tmSVo2NGc1?=
 =?utf-8?B?M3c9PQ==?=
X-Microsoft-Antispam-Message-Info: MWGdcJ5TyNq+Xg6wNMMsNwUl9F+hFYMZNwdFqGntp+HAPF+Mt7aKCdvIlrP68SSdaX+WHC4Fby7xAJqveksM/fsR3+chTVQsixCerAB+E9dOoNpEDPEU46gVonYFXRiju31mLEGQKzjRKyQLG+wFPjLUVTFQF2E+IB2pew9UaLxTce0Ex7rhv5e2PrXNQkpj+2hYGh5EaBhYUMGm/9YTpmpAcENolCYoNOtMXwV4xgMZwXhZe4G1ELAbSBgzekE3uFJ9SgTq5MkLmDbcQTxFIM5Quf19HfGmTqurQ5amPBxjDnsjlIHQ/81Ndn+jyy01zY7mT0stgKFjkFmf7qivGDUXOaKM+cyKqYgH4MghADM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4649;6:AEfpRS7vrDHzENOvUoSSADayYlB4Q5kI6fqgV5Gb4XlZuoJzExikwBNyYNRkNJJJlIZ5vBSkWYplbc8oxCa/uutoXGGhsbM3aHFag3F8Ny4D8sseyUK3rUKq1EopNmye21ouVZ8QQf13zjT+Esz5uuQ2sJQs+N4abEyjk+GFgW1FzDTgmufmuqPOIwqK5uvkdRmITrqtve9VXjK/wgoFgC6h7W/LvqIjrQDq+7MVsvEWFY3hTbpEtsOc59BDALPUZEvqHdmdlf8FkHp9VgMAQyU1XSTBVrwu/F6P09xH/4vxNzYXvkTQcKEP49pR7Bcp0J9M7QcPiBnM3BQIAIaUyq2sM3mGlMC610enZDNqcd78KbG9mYAekiukpIbaqDZVqSom9fLVZtIO/IZQsFWKdtPjj0n37p99eIA2jOPuK38CijLItnlfT3CJUppWI2YPThkFG+3iOPfjqGjvzJ29gQ==;5:kVcoALVp2/8Pl7rHojPhWZ+if9kWbRbHWadGpj1XNWbof+H6f5wNWWaXEJ09rD0aHhzFmzmsWdM5eBl9BU0Ga1JJj8elOkqmE0HiqOoSgOAysUqpb5qF3vjV1CPyd91EjWK21V97EESrJVO0P5CFcx18mmSuD+6vGs8eyT1+0W8=;7:OGdbHTw5eNkJD7gd3QO9lmlHUE4zZy3Dv89HXeyZvd7JjTzj9F7YUuHDot0JyD18pUyvlBI4zoFsQ+vFTwsRjdBCvC9+dfmE7uEMrI2Sxqm2lBomtrCBrnxblDfYfu3xRTAPXo+ahw0Q6WvQw14CGJTr7n/mUk3Sv3D4UnHMt1q3pPIqb8zbnHx9PRIU4dF1hbiY1hBWc7rGpNRQoB8hcXd1XbosyVPz7esZLCeilywhjC/ucufwryHjUb5Y6W/r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:38:24.6315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d761e79b-f994-49b6-20d7-08d5ecb3be7f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/2018 5:17 PM, Bjorn Helgaas wrote:
> [+cc maintainers of drivers that already use pcie_print_link_status()
> and GPU folks]
> 
> On Mon, Jun 04, 2018 at 10:55:21AM -0500, Alexandru Gagniuc wrote:
>> PCIe downtraining happens when both the device and PCIe port are
>> capable of a larger bus width or higher speed than negotiated.
>> Downtraining might be indicative of other problems in the system, and
>> identifying this from userspace is neither intuitive, nor straigh
>> forward.
> 
> s/straigh/straight/
> In this context, I think "straightforward" should be closed up
> (without the space).
> 
>> The easiest way to detect this is with pcie_print_link_status(),
>> since the bottleneck is usually the link that is downtrained. It's not
>> a perfect solution, but it works extremely well in most cases.
> 
> This is an interesting idea.  I have two concerns:
> 
> Some drivers already do this on their own, and we probably don't want
> duplicate output for those devices.  In most cases (ixgbe and mlx* are
> exceptions), the drivers do this unconditionally so we *could* remove
> it from the driver if we add it to the core.  The dmesg order would
> change, and the message wouldn't be associated with the driver as it
> now is.
> 
> Also, I think some of the GPU devices might come up at a lower speed,
> then download firmware, then reset the device so it comes up at a
> higher speed.  I think this patch will make us complain about about
> the low initial speed, which might confuse users.
> 
> So I'm not sure whether it's better to do this in the core for all
> devices, or if we should just add it to the high-performance drivers
> that really care.
> 
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>
>> Changes since v2:
>>   - Check dev->is_virtfn flag
>>
>> Changes since v1:
>>   - Use pcie_print_link_status() instead of reimplementing logic
>>   
>>   drivers/pci/probe.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac91b6fd0bcd..a88ec8c25dd5 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2146,6 +2146,25 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>>   	return dev;
>>   }
>>   
>> +static void pcie_check_upstream_link(struct pci_dev *dev)
>> +{
>> +
>> +	if (!pci_is_pcie(dev))
>> +		return;
>> +
>> +	/* Look from the device up to avoid downstream ports with no devices. */
>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
>> +		return;
> 
> Do we care about Upstream Ports here?  I suspect that ultimately we
> only care about the bandwidth to Endpoints, and if an Endpoint is
> constrained by a slow link farther up the tree,
> pcie_print_link_status() is supposed to identify that slow link.
> 
> I would find this test easier to read as
> 
>    if (!(type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_LEG_END))
>      return;
> 
> But maybe I'm the only one that finds the conjunction of inequalities
> hard to read.  No big deal either way.
> 
>> +	/* Multi-function PCIe share the same link/status. */
>> +	if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
>> +		return;
>> +
>> +	pcie_print_link_status(dev);
>> +}

Is this function called by default for every PCIe device? What about 
VFs? We make an exception for them on our driver since a VF doesn't have 
access to the needed information in order to provide a meaningful message.

>> +
>>   static void pci_init_capabilities(struct pci_dev *dev)
>>   {
>>   	/* Enhanced Allocation */
>> @@ -2181,6 +2200,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>   	/* Advanced Error Reporting */
>>   	pci_aer_init(dev);
>>   
>> +	/* Check link and detect downtrain errors */
>> +	pcie_check_upstream_link(dev);
>> +
>>   	if (pci_probe_reset_function(dev) == 0)
>>   		dev->reset_fn = 1;
>>   }
>> -- 
>> 2.14.4
>>
