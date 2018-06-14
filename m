Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 31AA2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2497208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SewKX6Iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2497208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936032AbeFNMEt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:04:49 -0400
Received: from mail-eopbgr710067.outbound.protection.outlook.com ([40.107.71.67]:44049
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754966AbeFNMEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/NenRArB12fyWuSAu1HjcC/RxGhxRFNIWX4LdEX41A=;
 b=SewKX6IqyeZDCA1wWYiLYrMAG3cI0l34QHCBCscEn2pvSzkVimJ9lf1szeB3XWr/B0ZDswGNx+uCVnZyVU9UWL8wxCeBCKM5NUhZ2mcpcUOAnBCN6qQzen+sj7hUeFps1G6nP41zJJlAAyErrSOih4IKSWqlZXBw9KRyeq3laPE=
Received: from localhost.localdomain (155.4.205.56) by
 DM6PR05MB4588.namprd05.prod.outlook.com (2603:10b6:5:9f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 12:04:39 +0000
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com> <20180614103852.GA18216@andrea>
 <b84a5ef9-6cd1-7dc9-a51d-cb195cdea83c@vmware.com>
 <20180614114944.GA18651@andrea>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <d01185f5-8d27-96e7-0875-275beecc21e4@vmware.com>
Date:   Thu, 14 Jun 2018 14:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614114944.GA18651@andrea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0502CA0015.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::25) To DM6PR05MB4588.namprd05.prod.outlook.com
 (2603:10b6:5:9f::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c69360f3-98d0-4bf7-ac36-08d5d1ef03a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4588;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4588;3:JrBjEawpQtywHdn20W0997UglVZ+GstdIld+jFM4AEsddAiaOVmnuejnebSSUtLC3slfeo/i3ysJxL3IChhuVs1RN249GHpsO+IhegXVPJi4oP8XAfY5fcSfoOP1cx8/lO93N3SAvAQL+rdqYT+4AcvmfiGA77mWTZ1S5nuV12klTRckOGvtUdO6apbYrW5Zhb8BC6g7kDp4dnqYevpoYCLDE/HB6/lE4hJY0kFZCT9+62HSazpBI8+FIoBPd+k4;25:sdDmdPSVJPOM7bFYvvh+whEDzTU1m1LEAKptNQiW/WrLZtGm2eN1NzF8m7dK/N8hcggiS9drWK3XGzQXEzUzMSABe45cXmZGQkv03A46P/oJ8hnJNT+Opyx3RrmxTEKDBCsXImYdlTvDEuHJpdav4bxjaW26zaO5RhHQ3pYADv3iahdwqBmdjKp7oqJQt428aPdPUCTwlyJeby/2QDNSAsIgxMva/hJLuaJsH11zMr/caeI+2lMlqaFqt+WQnWTA7iWu+7lAr2JpM2sfiMXocP9gS8umSJU2/6OdEz6v2Mb5RvLkT3n8pVQE9NoilAngIbIwSbCBuvEifXkLU+w2cg==;31:58yQ7UlJWBVS7d1fsTuHWOrcEKIneqx5ojCoEtotJbdZEcem+iZes2+CqhN7/56tp9sQ3lfeRzEbCxqXzIughlLwJzyLq0QONYzJ6ZOZi5S8lMeeHhtuUGtbD/UtFdMZXf/RxvaAFOteTR86aKrdAqCzo43S2cXhQ1NcJHhJMIt796KGBkSMfdR0RBGrAa0bwDoPSf7d7tg0GofheJhXPoBMe0uHbntjqFSvo9TZKRs=
X-MS-TrafficTypeDiagnostic: DM6PR05MB4588:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4588;20:Q6sxW/d3ZfZNPIiAj6lq3IgQuG0Q0NyZ877qCY+NSpatecQ3ZCbWaztTPmBZWG6/X7Wl0DKx9YYGV6eAo/bF0Av9krJYnemZAJJRfE47jInpvy/Wcl09jYkPMHTd9zQQ6OBAtr7ZZ9odQs9T9o0AE7TjhRC5bHw4Dqp2XtL+8cMU/34UIBKwm6zlcmcOOApmJc+UwpeXgsFcLKB1s9cWPwGkkDiedbB9TDlljHJ+KgBNeAyKs1hnOXw7ePo9HrbLTucnKI6Ahwbh4ihhtRp6EG0GkKnffxd2bTMJPtbLPtHULyhnfsexrj1SdZ3P8CYOekEdvN3KGBmMqDm0vvkw/ihnDtHoIE1HGJIjeHNCCU7WkNmrwoCosPBaUZYHOvxblHY8BZ1UvXj53WJ0LPYKp8A7PaX+jPgl36B7kbDsrw/6QMUG6Jj7Og7vV/cwAjVO+2wIT3BBkXkbNl/sAGPuEPdMpTgnm0+t4MxAD2lOgsvDNNdug1SLvJeYaAV3C6yZ;4:8w5hqigf7pXPe2LsqyGl99Pihpzzdjubg0kpK12tbc9f1hTpXpRBI/LyPVKUQAnAM2wqEny3yOzzzaT8GeKZPAVjzFVsJ3zAPtR2weUoLN9wPt7D7xbHFFG4znvsizpBRvY8pEeRPsFrjhvNj6/tRgxLOaCts4+ffqlV5WYEYCK2ALkPN3wG2GjNwkZiPzBgorFwFL2oV/WICdt1XpuNSUX5+9KvzG2b2C+bIJd+dB1X8WKrMYgfxP9TLTXGhpxoeh/uTHhbVPiSZr0Rqx7npQ==
X-Microsoft-Antispam-PRVS: <DM6PR05MB4588010E951059898AE0A9D6A17D0@DM6PR05MB4588.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR05MB4588;BCL:0;PCL:0;RULEID:;SRVR:DM6PR05MB4588;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(396003)(39380400002)(376002)(366004)(346002)(189003)(199004)(6486002)(6916009)(54906003)(6666003)(478600001)(36756003)(93886005)(86362001)(64126003)(31696002)(316002)(50466002)(8676002)(58126008)(7736002)(97736004)(2906002)(31686004)(305945005)(106356001)(105586002)(65826007)(229853002)(7416002)(5660300001)(956004)(2616005)(476003)(446003)(486006)(11346002)(65806001)(16526019)(59450400001)(6506007)(53546011)(386003)(25786009)(6246003)(26005)(4326008)(81166006)(186003)(81156014)(3846002)(230700001)(6116002)(8936002)(68736007)(23676004)(2486003)(67846002)(53936002)(65956001)(52146003)(52116002)(6512007)(66066001)(76176011)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4588;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA1TUI0NTg4OzIzOkQzV0NGSW1pYWJ1aVNWeG55aUhIZUZQdE9Z?=
 =?utf-8?B?V1BjbEtGOWRvTjFkQXRBNWNzQnU2eHpndGFId2ZJWEJ2aE44ak5RWEMweU9Y?=
 =?utf-8?B?TzByMHYvVEhXbVZvb1NvSVk3Z1hod2ZRKzlwSDVYSnhDajdFNHRQVS9veVF6?=
 =?utf-8?B?MW1PTXI3OEJ4VmdBVnpSeWtSR0VHM28wbDc5NytIbld6eG40Z00zbUlzUGlq?=
 =?utf-8?B?cU5qNTdDQ3ZaeXJVcEVrTUN6a1pJd04wUjBTZC9LREt5QnNvRkFTVFZCMzlo?=
 =?utf-8?B?QkN1bzZPQU53MjVXSjd4SXh3Z05rT3JYVVBIL1YxMzJJTUdIUjFxNVNjL3dr?=
 =?utf-8?B?VVZKQ1VoTzQ2cVRuQlZKTTRWcFVYelhqQU8zb0d4VzNaSWpwYUUwOFpLUk5L?=
 =?utf-8?B?QTh2NWtYRkN3bmhPK0piWVFvRDlBd3BaM1ZoUXlzY2dqTnBQeFdQb3VpWnNa?=
 =?utf-8?B?eWdpVURHOWhDdTRJSHVtTzFqOUpFRkFwQlNiS0x0S3BrTytvSjhzL3NpcU9K?=
 =?utf-8?B?aDhOWEt5ZitJUllRdVpzM2k5TWFPMEs5bm5OWWdBRGk3TDExZ1ZibXA4c3ZO?=
 =?utf-8?B?TXU0bmRlc2pxbEgwc013eU54OURtZ1d5c1FValVITDE0SFJhWkFvQS9DWTRI?=
 =?utf-8?B?SERscTBnaHUvemNCaGN2Y2pudFpvSWVNZjN1R1JaSmZWbTF3Mk9oekc3SjdB?=
 =?utf-8?B?aVo2U080SDZRdTJLVnhBaXZZRXdmMTkwcVB3NUZKWDQvRjB5amQ0Vzl4anFa?=
 =?utf-8?B?TXdZa0x1YmgxRWhodVVwcmduREhIaUFlUnlYampMMlByblZHU056VGV4QlNy?=
 =?utf-8?B?MEpUbDR5UzJ2UEdUaE9NRzcxdFpDa2gwbk5xWmtiR09la3NUejdLS0dTK0Vz?=
 =?utf-8?B?ZGJQZEpnTVd2d1V4WFVxMHhRN0ZKd3ZSQm4yMitOVCtVbFRqR0tSREoxQTRT?=
 =?utf-8?B?alhuaUFDendQTTIzR3A4Z1BwR3FuaCt0dzRnditZYU5OK2Q4TnozTS9JYzN1?=
 =?utf-8?B?dmtoVWZkdGdzNS9ESllMVGNTeXMzNk5sTTJmS054MmQxVG5UaXpvb1FrNkpG?=
 =?utf-8?B?OC9PSEhvaU92emp4c21od2g5Y0RzaXNZOGVrK3d6UnY5aVJIS1R2aW5WTUk2?=
 =?utf-8?B?eTI1S2IyVFQ4OXprbVp1ZU9jK3I4YmpjUUxoM2dublJoS0R6WkZrbnFvcmdj?=
 =?utf-8?B?R1psYTRaZ3doSlg4eGFPVEl0Q1JHZnlyQ1RBdjZrbm5KSkF3VWZQaUNSRW1H?=
 =?utf-8?B?elp5d0pPdGFWYy8wN1I0U20rcFJwT3p2bHZmZy9NbFF3TmlxWEtYbno0YWpE?=
 =?utf-8?B?Q0pIeWE4QjIrM0p1SXJQRWpsTXRNNWhXTFlzMCt3VGxtNGJIQzJGQThSdldF?=
 =?utf-8?B?SkxYSmZieXRQZGpLUk5UZHhnVy9RZ0lsTXk3QWhWeVEzM1FpcFlFbFA1dFZH?=
 =?utf-8?B?UVlXOEIwZzNiRW9hNmZhNHQ0dVVuY0kzTXZBZi9TSS9sZEdMY1UvaXo2YWpu?=
 =?utf-8?B?YU5IY3pDam1RMlo0V3hoZTg2UFIzcmU5QmRKMUZ1amhqOXhiZ3ZPQ0o3K3py?=
 =?utf-8?B?NU44YzBlc0dXVHVJcUpIcFcrZVVKZDRmUCtiN3lGb1ErNWozOUg2UCt3UFE2?=
 =?utf-8?B?Y0QzbHAyM0IxaUhlQjBWeHAraEJtODlCL2RyeFNaTlRaeThHeTB4SXFIUHhi?=
 =?utf-8?B?Uk5tM2E1VkZudWRrSUhvK25UZ2pTYWJtT3FOMXJBL2NrbTNRU0E2eTZScS9R?=
 =?utf-8?B?Y2lVRm9UWWtQbnBFeG5lZXJ0MjRHa1crV1ZlZisyM2VDTnFRaXF4dEJDM3Bm?=
 =?utf-8?B?cnIrYzhRS1hXV1h2VWZ3WmZ6UXM1cXJ4L29JQmY3cWhZYlRSeVdqV2RwbUNJ?=
 =?utf-8?B?VWorWGhYb0pLT0tBQ3dhU3lNcHBwMkV1alJEdzd1UWFtWXNnUXFDWEdUWEdR?=
 =?utf-8?B?M2kvRTFvVlV5cXh0Tjg0WEY4a051MFRyTUZnOXVaQkhmNkE5S2RjaFlBcFR5?=
 =?utf-8?B?VHRaVFRYb2hyaWxLSVk1TVBEUkdMeXN4MW9tYittUlg4YW1VV1E3NHZNUEJW?=
 =?utf-8?Q?jvFsDljSvzF0pvo7pwohKGfg5?=
X-Microsoft-Antispam-Message-Info: TsQWtFJnru2RG3RS+1UC4XVaecjGB1CRnGqUnxUjO7YfmHOrTMMMCdGjFsP1WfLWdITpblu4b/GtbcZjymGCMoi/y7/u2H+dwhcdL+PM+UW31owJgiLnQd6DsWSyQaBH+AYuvITw7LUrQHQBWQF+uxdC99hSYEBhP/C62T4yAV9YGsGfoO3vzPhD2F4kiVPa
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4588;6:A3zSfVtFxebDs5ZSoxu6b9rrLF5oMbMsx3Aq4+NrEp8enu/Co6NGuwYY3qVChRd7eyw5QcjKCvIT6/0ezjyEPqmO+dh1yaIc2jaBDRyqCDf3tFE7w6eBaT+lvkLGNHUjJp7geCRk/0CWJB0T9PXDmk77sRbAZOG8wrHl2NTkYySxlKKfaPF4CO8CmN++H5Z2EwIPIzwgNvb/vAYcA2YhPjw3Gk//z5TdCr4Oqp6ghmLf3dl6eRcd963PaDNGSDpLhI4GiVfLuzMDs3jWkokLZRKtNq96yZuBEZYynyUAneW1Iuv90pmSBULjAyL3eETXsgRf1EV/NBJn+mV3xGA6jBDFTuQA9IsPHjuJHEPjgl/0305H2yJP2JUcpQ7wH6+UCP4i6aoMsPRYGEfbOp+tMmZsoHJhelsxMqJcBr0jEPyd96b1pXzhe4y6ZBb7LfzPwZEXZ+Lkv0x+6KXcERhE6w==;5:8EpsroyUxezDxzXBcxhwQ0ayQPGkQFRXrY7ehjWC7dI3eUvYzoZJcv7zdqgt9X3I0NdWm4vzPxVtaj895MVulkL0vy0J9bBDiBvwb33vjkgRut4Oyyr8rH99Be8dTXHIW1pgWAYPCyXGU00AfmbKBfQlqHRkpDOb5YwmwD7jk5k=;24:Ek7oTW1YnqucPup3wmNBOM08Q7TL6K9/ZOBotBxLNoBpmqhjg5dhicgE01GVb1ilJV0Ma6rG5nUW+Xfvztjq8yBgrgTsHsvUOx8yTvskkRI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4588;7:nj/ugMmdjU+pz+Hlz4iahlYGD5FDNZa7/vKsexyYu9r0XrNk88rghbt9N9Q7IA8NQ4tWQeeItPfHcMAYgl0fhLGu1B+UdGjYezEt/G4xu26DZt8HgM3zdleXQYAKi4EkdyKTbBMgvuHNlUje+3v9Zhs/GpELKl7Mc9rWScXSsTlLJzdRa5DBBJs6M7KSUSGcAcvSu6cQWg3rqRRFWpKUcF5LFC4u1BD9w07801cUny/VtVl1V9eqYMaUeDsfSJlt;20:EbOEfH3vSBMsAFt5FGXXyhH2Ipf5XRU/dB8rUCIeZQqZkYd1KSHEpKrWEID6wYPBh901fzEtIDpSC4R7xzfoLZxgBVc33OJ2Lgcgzhfyt36Zb/BQTVUKmTs6FKvNnNG3GrF76LMq1dJ/hr/UK70u5O/fu33zHUdkzBuepzxSjfk=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 12:04:39.4630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69360f3-98d0-4bf7-ac36-08d5d1ef03a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4588
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 01:49 PM, Andrea Parri wrote:
> [...]
>
>>>> +		/*
>>>> +		 * wake_up_process() paired with set_current_state() inserts
>>>> +		 * sufficient barriers to make sure @owner either sees it's
>>>> +		 * wounded or has a wakeup pending to re-read the wounded
>>>> +		 * state.
>>> IIUC, "sufficient barriers" = full memory barriers (here).  (You may
>>> want to be more specific.)
>> Thanks for reviewing!
>> OK. What about if someone relaxes that in the future?
> This is actually one of my main concerns ;-)  as, IIUC, those barriers are
> not only sufficient but also necessary: anything "less than a full barrier"
> (in either wake_up_process() or set_current_state()) would _not_ guarantee
> the "condition" above unless I'm misunderstanding it.
>
> But am I misunderstanding it?  Which barriers/guarantee do you _need_ from
> the above mentioned pairing? (hence my comment...)
>
>    Andrea

No you are probably not misunderstanding me at all. My comment 
originated from the reading of the kerneldoc of set_current_state()

* set_current_state() includes a barrier so that the write of current->state
* is correctly serialised wrt the caller's subsequent test of whether to
* actually sleep:
*
* for (;;) {
* set_current_state(TASK_UNINTERRUPTIBLE);
* if (!need_sleep)
* break;
*
* schedule();
* }
* __set_current_state(TASK_RUNNING);
*
* If the caller does not need such serialisation (because, for instance, the
* condition test and condition change and wakeup are under the same 
lock) then
* use __set_current_state().
*
* The above is typically ordered against the wakeup, which does:
*
* need_sleep = false;
* wake_up_state(p, TASK_UNINTERRUPTIBLE);
*
* Where wake_up_state() (and all other wakeup primitives) imply enough
* barriers to order the store of the variable against wakeup. And with 
ctx->wounded := !need_sleep this exactly matches what's happening in my 
code. So what I was trying to say in the comment was that this above 
contract is sufficient to guarantee the "condition" above, whitout me 
actually knowing exactly what barriers are required. Thanks, Thomas

