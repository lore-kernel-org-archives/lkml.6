Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BE09AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484C6208B2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Bh+4gjw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484C6208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbeFNQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:44:06 -0400
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:2912
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755071AbeFNQoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpiWffabfGNfAWBuWltNb4tcBeuPy5jEaFV1NchzOLw=;
 b=Bh+4gjw/oQEsecSIWQvQ2swWOdM1JFTSCNNrreFfTvs3qG3l0hn4wYJBtd/moVweYP1ywZzsOAKpl5NDf17+7Xvq0/IoP3R1fuh0U/c9pNgOlAH8XNh8kg0xEwvbgYduRkfEohGQm0uyhzyHYKzXjornNVISVIxq3iQ74ZuS7O4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 SN6PR05MB4589.namprd05.prod.outlook.com (2603:10b6:805:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 16:43:56 +0000
Subject: Re: [PATCH 1/2] locking: Implement an algorithm choice for Wound-Wait
 mutexes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
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
References: <20180613074745.14750-1-thellstrom@vmware.com>
 <20180613074745.14750-2-thellstrom@vmware.com>
 <20180613095012.GW12198@hirez.programming.kicks-ass.net>
 <69f3dee9-4782-bc90-3ee2-813ac6835c4a@vmware.com>
 <20180613131000.GX12198@hirez.programming.kicks-ass.net>
 <9afd482d-7082-fa17-5e34-179a652376e5@vmware.com>
 <20180614105151.GY12198@hirez.programming.kicks-ass.net>
 <dd0c5e50-ac14-912c-d31c-c2341fdd2864@vmware.com>
 <20180614144254.GB12198@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <5a1076ad-3c26-d78a-5542-9e767d81c4a6@vmware.com>
Date:   Thu, 14 Jun 2018 18:43:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614144254.GB12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::25) To SN6PR05MB4589.namprd05.prod.outlook.com
 (2603:10b6:805:38::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4acdf15-d87a-4758-2b9e-08d5d2160779
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4589;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;3:+pIyD7A2dF45s74Lphs6H6olxFpGExtUo1TFs+7cs71oXsX+nqTOp710g8nWA6JlqcEEeZ45zfYuhBtC2ZEXQeL1KVl+iFDKkXmO8NZjGRZUTdKD/U93HxXlwmo+wYGb5m4ZXQW+0gWB0600pfw4YRgJGlggt958bytAQ4TANxNnX2oHvXJFj2B+d+ScxoZcd8hP2XzRz16X6lQDhO456G7h/0Kr8OaZnJY0BMPH44713snS5D/H5rppkr5+q15c;25:X87NXk7CWMGEAxURFglWTj9ndVGKhX3AkEhEN2p2qw5LzpsdfyAXgRbHm7dwR1ofYSFy9VgirX9wXTFWZ/tL4t6+2uRNlIGmgIHiYr0+ijhVBzRAf/3hQ9ThJakbkWlIy/zmnw+UCccTZA8zLbO5qROPX/fBcE3A2LFt96V/vVxNNrsrV5vLF7xIIlj9JXutts7ys8tsZOp6T7xnaqUqewRY49InyvwLLh7J3cLoKSGXx6CbyFROlK0+U8IInCGR/xECqhSHoGoAuYJEYIlcKeN8MUjKxP8r//5UZuJHuwEp9weB+yCDYlOo6ED5ATV4I4iH7fkFtDKPPpFIi4Kh2g==;31:FFaWxiQHwL2vWZSiN+HoXLMHOe+1K6P/fpmXPIhexHxD05xaiQ3O4Tn3j9tWNG5Be48jKhQEi2t3a6bmgRADeQPACKWW4moY5vHXLJjGwWJNzVlJXx1XLTFrhP/DPzlTpTsc44rpNGug4c4np1vJktmjZdLYHcW+4UBNKTFFJhD+g+11D3TF0oN6Rc4DyajoBp0YwcOGRfKEuDcyhvTv27IjsxKVHSU3fkjSDrgrFbs=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4589:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;20:i8/4R6jPoCD9dNNOhTV0zm5m5aSlzeW5Km/UoWkD7FRvU+Bs/DjVTkl2xxYqpbIRHTjULf0/4trUqlWUjsBg/lH6ZVeRyug1S7/hD1txEgQwsSv+UH6cWCAKLNP77IIZ3FzpzooLbDwptaMQVY7MGeOWrquuWhOCumCUw2QjbjTkiIK8olI6CzRTlo8Jyb2BjKjTuEFYlfpKFZHfbRYXHhmmnafIHpbw5oRvwvxU+N2NrkpAQ8CnS4UrYoBIrx7pKKo+TQ2m7C8y+OS3Nc9EICL4fxhWDC/CKSq+9FzjFIK74mS6IUzUj0VYPFX4G9kuvz2s5VaXajMObOlNfebceSGlJEXw/gngHaYQZzuWNXbqttUvktCpu0gJTYhZUb/6bJa93GiqGztSHkEQESx699NrBCJIHnJFs0aQOqopLb2ddHrIHje3mJmPlHxGZVNSIaG7DHTS+ePljj2kbYQ8EcoSA3R42CF30z2xad3fDIg6bfq+aAj18kIkzKqjc/qo;4:TuiQlJu1k3cJbMm7XTYJMbhLCOwlWA0HfEu6sQp0LmuGpxcAa2H0F2M5huYlbQuFQDgZT0XzNcj5ScAHbHnoWEVqYjyrcAjMhFK0E81fskFW1YlVltbsXzripZdSKZBrcJuvXck1js2kZa1qzo6QRqZH/42Av8/75H6hs+U9h3xbLaYumxjXtiiBEuvC6TJ9fJfg34UMfDgKz8qYdrKEOkKpm+Y+llxXUgeK/nTkNbyvS+XFdwFOZG1HEm9QWK42NlncwDVlWshhEhTJNsSA4wWgHhPJg7kbewuqf3TmkQ3c/tmPsktJUyYgKcR9BUrz
X-Microsoft-Antispam-PRVS: <SN6PR05MB458977A6D044B11D5571EC35A17D0@SN6PR05MB4589.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4589;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4589;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(396003)(376002)(346002)(366004)(189003)(199004)(53546011)(5660300001)(68736007)(76176011)(31686004)(93886005)(4326008)(97736004)(65826007)(26005)(53936002)(386003)(230700001)(16526019)(186003)(105586002)(106356001)(6506007)(7416002)(2906002)(6246003)(47776003)(25786009)(66066001)(8936002)(65806001)(65956001)(3846002)(6116002)(59450400001)(64126003)(551934003)(81166006)(229853002)(446003)(11346002)(6916009)(486006)(305945005)(36756003)(58126008)(7736002)(8676002)(23676004)(2616005)(476003)(6666003)(6486002)(86362001)(956004)(6512007)(478600001)(31696002)(52116002)(316002)(50466002)(52146003)(2486003)(67846002)(54906003)(81156014)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4589;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA1TUI0NTg5OzIzOnB6Y1lKOWYrV3E3eFJxS1B2dGVhRVNGZUNp?=
 =?utf-8?B?ZldIRUppMHBNalpQNjd0VFZaY1IzNjMvcFN1MS9kTVNraW1YWWFuNXhOejFH?=
 =?utf-8?B?c3F2RXdZVDlDdWxDL2tDM0xDTTVZV2VHMGQ3cmx1R25kQVQrRXRFQWkvUTBF?=
 =?utf-8?B?N1BFVEtnVVRpaGwyMkJ5dlQ1emVzMHpCcFNhT0dOaVM1cEFEQThla0hUdjZI?=
 =?utf-8?B?eFRVTnJvcElEMEF4clk2c0J5SXNwb0JEUy90MXM1TE9TWnlIT1F3R3hlZEFO?=
 =?utf-8?B?TFJ5cDJoSmw5cGZDT1lRdjk3Wi9TR25aQ3IyWFNvSmhnanNVTWhUSUFvRHhU?=
 =?utf-8?B?ZDEzMnRreUkxbU1YY0NsSlR5VjJlS1RCNEtaZ0QrUzVFVHlpY2hQcTJhQ2pW?=
 =?utf-8?B?Tlo3dVhFVW83bWhkVFRUODl4WGxVRHlsbHlsODhORW1yR1pNMWhveDNibVFK?=
 =?utf-8?B?UFFhZ0xyWnV0RUU3Zm43bGQrN3FIM0RrejNLV0dSNzJqdjk1YVRDVEJVNEQ4?=
 =?utf-8?B?VDhsTVBjejh1R0Y3dVFSYktWRUozdC9aUVlMcVM1ckJLTjFvUDB6VU5hZWdV?=
 =?utf-8?B?d0xoV0E5K0VSL1JFRmFzVlZlSjJSVzFySFZ0OXBSUHNTUEU5TEJ1NUFld2h2?=
 =?utf-8?B?UlB5UGR1cXZXZjVSOEt3cjI0Sm1CSGVPMTl4S1lQOHRkTjRtam8rUFpXbVp1?=
 =?utf-8?B?RkM2VW9FUlBXM2c1eVZYc3pXN2JIY09rVTUzK3pMdTNmanFmY0VPaVM4aytL?=
 =?utf-8?B?TnAyMWlyT3NuOTN6RVNKeFdQU0x6dStiSVhnVTNNT2FRM0pqMnhacGdtdVBr?=
 =?utf-8?B?WlBNWGp2L2hjdFlWcTcxUjF5d2VCa2w0VEV5SWxWdUc2RlJidzZvNjRVU084?=
 =?utf-8?B?bFNnVytXNEw2VEREMXVVNlpJbG5KNlUzTkNYWkhLQnF5ZGhKTDdpT29kdURM?=
 =?utf-8?B?YU8xYzh1WUhkRHcwRFlFd2FlNVVXZmtUWHBUSFVPT3JnVGtuTlJhNDVFbC9w?=
 =?utf-8?B?OVhuOHQ2NXAweWRjMDcweVplaVVVT01GUTFBb29QYmpCbS9XcjZzaG5ZU0Vu?=
 =?utf-8?B?NVBSdjMwbTV6em1IMjRiRTNtRG9QVk1DUmdqMnJWTWpFcytscXNiSEl4SzIv?=
 =?utf-8?B?YTQzbXg2QWkxU2t3ZVdUTGpFWlVhT2Mydkh2MXAvUklBK2gwcW1zQVNZNHJ4?=
 =?utf-8?B?R1N6elUvcFM3MWlEWXNLdnAyS0xXL24vZFZTcmhvUnRwejVZS1VsVkNyd0R5?=
 =?utf-8?B?U00xdUN3L0hLNm42ZEhSQ3BaTHExTjlEYmNLOW5Lb2NMK3RKUzd4RGl2WTZU?=
 =?utf-8?B?N2JVRExoZXNTUmMrNEIwSkFnMmp5bmdzZDZZQ0IyMkZ4SDFTUlZudkgybVg5?=
 =?utf-8?B?RHROcTlwb1NyNDZtdXZualNBZXk4NkJLWVJHeStreXAzVWNnU0tPdWMzRVIr?=
 =?utf-8?B?S3ZwSDhRekVOendJYjljYmQwbFZudUdGTWtBZjdSZFJwYWhBeWhpQmxDUXdy?=
 =?utf-8?B?SXVCWkZOT2VQenhWTkszcWcwbDRibXdYaHZQVUxGUVBuQnowOXd5MjhZZGcx?=
 =?utf-8?B?SUxVb3o4WVJxd1p3bzBzY0wrZXdYelgvYW1UWTYxVUVaeTlLWklrUDNieXN5?=
 =?utf-8?B?bFo5L2o5UGNPd0I4VDltV0t4UEhxYVRDU2YyNkJ5MXhmMU5XNDBEWDV2Q3Ey?=
 =?utf-8?B?SGtYNStYcmZVZXJVVzB4cGQwWVhNL2NRdGJ1ZWFOWWI1dUZ4VUFScEtuM1A5?=
 =?utf-8?B?TzY2K2M1T0V6YW9nakhVeHgyeVNIbVlKcW5RTVdvblkydUg3a01jdStIQzlk?=
 =?utf-8?B?Z21xY01UM1FtbllJSC9wdEVWSkpTa29udGFKUEFmQUhmZkRqQ2JaUDlqMTJl?=
 =?utf-8?B?VUtZSGhrSHNOdzlHTFNKMzBOREU2akdhNlhuRjBjTWQ1MVplVGV2MW1qYkFB?=
 =?utf-8?B?dml0WmlPNnZiWGRtRTM1REM4L1YwWkc4N3dYV3BQaHhyZ1J5Z1cwTHNzb2lw?=
 =?utf-8?B?NXFpcWJFaHVqZ3ZWbjBNQUZIdldCUGN6RU5ZMkJkbjVpUGtnK2FUaWl1NzAz?=
 =?utf-8?B?SDNZU0RiRlpBQkJqN21za3VVOEhuRFFmZHpKRkhkOU5TUUpyZm90dUlNWno3?=
 =?utf-8?Q?4FwSaj56384RfgrrBn9XbOY=3D?=
X-Microsoft-Antispam-Message-Info: 9fWqc1FgMP9wRc2DMNBQjufmJr/Z8pW96QF5RrGBLWYbugXfKVIwnqy9X2tGAgv4ipZswlQZOIV4vFSGl7HawY9f23Dhf9P4QOCFS91tcIAIYprqDXR0Fnhs5dBHAoIJtpaw7HFWmIjJS8mWxMMQbwIFfnGbmHtYuVZbxp/sOgGyCd6YCxhcKhA7SGHA043d
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;6:cHQapr7UJU7rAru/pmKMTOzh+6IKZgMnVqWr/6W4HPpkyjQRJ+Abt+fH+IwIOOwsq00J/OHdcYu93fH7xBEUqXVOYc3PIcTZ0CGeOWBvo41Y48ydglRvCBgVAcQggU+XEOfPKB8I7c+9xCGhfvDe+mCuRW8WvmILXOxyiVTQfhSWQ6qi2I50cuyuzsV5xvLbLU3b2b9skL0ITvUdg7hI04GOiGp2wcVU3IO94EvPlvyGXAUZJYyo5Kul/HleGhhdXHRXlA2AonWiX1IEKzJ12vTS+6FZXbdWTzlHkQsu5tPGWzPwk5U/ALW82SylOk1t07SW00IZCoiE+ri/ipg42XXLi1QAQuh0MG3NUpO4xU7vzh/P1sJDhbVZOx4aw3Xk32IhLrFkSGqvAdCEu/EpCmuNXDFukUot1TTZoYKAOv3cXM9yjEh2CoLQ6QCfD4iSTvRZhYVvBwWmJv4S0NLYVw==;5:GTWiuQ4EmwO0fpM2dKDdkW3LK8rvekdMxt3E9mNTdDlc8LNX2KvBeJPtL+4nwxovXTLfUZlym9AH1mwo+Qj1rbgDDfY1uZ8MawffGjoLtTIW/fNvZuG2VhoOTm1cU6rM+5HokTri2n11Q1iv0G3BFZvmQlqg40ocgwixldH8+1k=;24:9V7z7YqvFzN4qUTnhy8yx47NMMjuVKraWjVtDwgeUX6eLiZ5zRFw/q4wAidKRgdB9gttkA0/QgcT94QpcbIsMNmZV/e0QAUKVyHxzzVglOs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;7:4HmdNDoKFI+DHJ0hHI5LIf01hjMJuMj2KWUBPHbLXu9MU6HyQ+bHXOzEE2gYzveNpXy6zMgtzuDVp3kPp8eGP3SQOaUaWKWlUdmxHKtgHWhfLupTgkjiFDRFLG6X2Flk6+yXiVsnE9oy897xB4A55VzXTqjMwhZXMFv3k2NWP/xC+hDtNTpTITzEm2Cmp1aj00JtFfh3rmBsRQLmccFRxX2FaSOTCm4HW+9Ia55GcR95SeLzUQfRo86StDwcqxsW;20:8aWRddsqnAznlZMfGwh/mTSoEOipBsVqQ9H/gF52YOZcMKo1X6oYK2ZG6dO37FeG27ap/f78wf0VcAa6Bb8qZsZnOwe3JLXCOPJ5e/TUKjyTYBzL0FkfOrWeKgc+NunRC7V7f36QP6TN03dxVhOP2ExZohRKgygIOn9gC4cvWcY=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 16:43:56.3453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4acdf15-d87a-4758-2b9e-08d5d2160779
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 04:42 PM, Peter Zijlstra wrote:
> On Thu, Jun 14, 2018 at 01:48:39PM +0200, Thomas Hellstrom wrote:
>> The literature makes a distinction between "killed" and "wounded". In our
>> context, "Killed" is when a transaction actually receives an -EDEADLK and
>> needs to back off. "Wounded" is when someone (typically another transaction)
>> requests a transaction to kill itself. A wound will often, but not always,
>> lead to a kill. If the wounded transaction has finished its locking
>> sequence, or has the opportunity to grab uncontended ww mutexes or steal
>> contended (non-handoff) ww mutexes to finish its transaction it will do so
>> and never kill itself.
> Hopefully I got it all right this time; I folded your patch in and
> mucked around with it a bit, but haven't done anything except compile
> it.
>
> I left the context/transaction thing because well, that's what we called
> the thing.

Overall, I think this looks fine. I'll just fix up the FLAG_WAITERS 
setting and affected comments and do some torture testing on it.

Are you OK with adding the new feature and the cleanup in the same patch?

Thomas



>
>
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index 39fda195bf78..50ef5a10cfa0 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -8,6 +8,8 @@
>    *
>    * Wound/wait implementation:
>    *  Copyright (C) 2013 Canonical Ltd.
> + * Choice of algorithm:
> + *  Copyright (C) 2018 WMWare Inc.
>    *
>    * This file contains the main data structure and API definitions.
>    */
> @@ -23,14 +25,17 @@ struct ww_class {
>   	struct lock_class_key mutex_key;
>   	const char *acquire_name;
>   	const char *mutex_name;
> +	unsigned int is_wait_die;
>   };
>   
>   struct ww_acquire_ctx {
>   	struct task_struct *task;
>   	unsigned long stamp;
> -	unsigned acquired;
> +	unsigned int acquired;
> +	unsigned short wounded;
> +	unsigned short is_wait_die;
>   #ifdef CONFIG_DEBUG_MUTEXES
> -	unsigned done_acquire;
> +	unsigned int done_acquire;
>   	struct ww_class *ww_class;
>   	struct ww_mutex *contending_lock;
>   #endif
> @@ -38,8 +43,8 @@ struct ww_acquire_ctx {
>   	struct lockdep_map dep_map;
>   #endif
>   #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
> -	unsigned deadlock_inject_interval;
> -	unsigned deadlock_inject_countdown;
> +	unsigned int deadlock_inject_interval;
> +	unsigned int deadlock_inject_countdown;
>   #endif
>   };
>   
> @@ -58,17 +63,21 @@ struct ww_mutex {
>   # define __WW_CLASS_MUTEX_INITIALIZER(lockname, class)
>   #endif
>   
> -#define __WW_CLASS_INITIALIZER(ww_class) \
> +#define __WW_CLASS_INITIALIZER(ww_class, _is_wait_die)	    \
>   		{ .stamp = ATOMIC_LONG_INIT(0) \
>   		, .acquire_name = #ww_class "_acquire" \
> -		, .mutex_name = #ww_class "_mutex" }
> +		, .mutex_name = #ww_class "_mutex" \
> +		, .is_wait_die = _is_wait_die }
>   
>   #define __WW_MUTEX_INITIALIZER(lockname, class) \
>   		{ .base =  __MUTEX_INITIALIZER(lockname.base) \
>   		__WW_CLASS_MUTEX_INITIALIZER(lockname, class) }
>   
> +#define DEFINE_WD_CLASS(classname) \
> +	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 1)
> +
>   #define DEFINE_WW_CLASS(classname) \
> -	struct ww_class classname = __WW_CLASS_INITIALIZER(classname)
> +	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 0)
>   
>   #define DEFINE_WW_MUTEX(mutexname, ww_class) \
>   	struct ww_mutex mutexname = __WW_MUTEX_INITIALIZER(mutexname, ww_class)
> @@ -123,6 +132,8 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
>   	ctx->task = current;
>   	ctx->stamp = atomic_long_inc_return_relaxed(&ww_class->stamp);
>   	ctx->acquired = 0;
> +	ctx->wounded = false;
> +	ctx->is_wait_die = ww_class->is_wait_die;
>   #ifdef CONFIG_DEBUG_MUTEXES
>   	ctx->ww_class = ww_class;
>   	ctx->done_acquire = 0;
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index f44f658ae629..9e244af4647d 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -244,6 +244,22 @@ void __sched mutex_lock(struct mutex *lock)
>   EXPORT_SYMBOL(mutex_lock);
>   #endif
>   
> +/*
> + * Wait-Die:
> + *   The newer transactions are killed when:
> + *     It (the new transaction) makes a request for a lock being held
> + *     by an older transaction.
> + *
> + * Wound-Wait:
> + *   The newer transactions are wounded when:
> + *     An older transaction makes a request for a lock being held by
> + *     the newer transaction.
> + */
> +
> +/*
> + * Associate the ww_mutex @ww with the context @ww_ctx under which we acquired
> + * it.
> + */
>   static __always_inline void
>   ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
>   {
> @@ -282,26 +298,96 @@ ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
>   	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class != ww->ww_class);
>   #endif
>   	ww_ctx->acquired++;
> +	ww->ctx = ww_ctx;
>   }
>   
> +/*
> + * Determine if context @a is 'after' context @b. IOW, @a should be wounded in
> + * favour of @b.
> + */
>   static inline bool __sched
>   __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
>   {
> -	return a->stamp - b->stamp <= LONG_MAX &&
> -	       (a->stamp != b->stamp || a > b);
> +
> +	return (signed long)(a->stamp - b->stamp) > 0;
>   }
>   
>   /*
> - * Wake up any waiters that may have to back off when the lock is held by the
> - * given context.
> + * Wait-Die; wake a younger waiter context (when locks held) such that it can die.
>    *
> - * Due to the invariants on the wait list, this can only affect the first
> - * waiter with a context.
> + * Among waiters with context, only the first one can have other locks acquired
> + * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
> + * __ww_mutex_check_wound() wake any but the earliest context.
> + */
> +static bool __ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
> +		           struct ww_acquire_ctx *ww_ctx)
> +{
> +	if (!ww_ctx->is_wait_die)
> +		return false;
> +
> +	if (waiter->ww_ctx->acquired > 0 &&
> +			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
> +		debug_mutex_wake_waiter(lock, waiter);
> +		wake_up_process(waiter->task);
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * Wound-Wait; wound a younger @hold_ctx (if it has locks held).
> + *
> + * XXX more; explain why we too only need to wake the first.
> + */
> +static bool __ww_mutex_wound(struct mutex *lock,
> +			     struct ww_acquire_ctx *ww_ctx,
> +			     struct ww_acquire_ctx *hold_ctx)
> +{
> +	struct task_struct *owner = __mutex_owner(lock);
> +
> +	lockdep_assert_held(&lock->wait_lock);
> +
> +	/*
> +	 * Possible through __ww_mutex_add_waiter() when we race with
> +	 * ww_mutex_set_context_fastpath(). In that case we'll get here again
> +	 * through __ww_mutex_check_waiters().
> +	 */
> +	if (!hold_ctx)
> +		return false;
> +
> +	/*
> +	 * Can have !owner because of __mutex_unlock_slowpath(), but if owner,
> +	 * it cannot go away because we'll have FLAG_WAITERS set and hold
> +	 * wait_lock.
> +	 */
> +	if (!owner)
> +		return false;
> +
> +	if (ww_ctx->acquired > 0 && __ww_ctx_stamp_after(hold_ctx, ww_ctx)) {
> +		hold_ctx->wounded = 1;
> +		if (owner != current)
> +			wake_up_process(owner);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * We just acquired @lock under @ww_ctx, if there are later contexts waiting
> + * behind us on the wait-list, check if they need wounding/killing.
> + *
> + * See __ww_mutex_add_waiter() for the list-order construction; basically the
> + * list is ordered by stamp, smallest (oldest) first.
> + *
> + * This relies on never mixing wait-die/wound-wait on the same wait-list; which is
> + * currently ensured by that being a ww_class property.
>    *
>    * The current task must not be on the wait list.
>    */
>   static void __sched
> -__ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
> +__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
>   {
>   	struct mutex_waiter *cur;
>   
> @@ -311,66 +397,50 @@ __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
>   		if (!cur->ww_ctx)
>   			continue;
>   
> -		if (cur->ww_ctx->acquired > 0 &&
> -		    __ww_ctx_stamp_after(cur->ww_ctx, ww_ctx)) {
> -			debug_mutex_wake_waiter(lock, cur);
> -			wake_up_process(cur->task);
> -		}
> -
> -		break;
> +		if (__ww_mutex_die(lock, cur, ww_ctx) ||
> +		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
> +			break;
>   	}
>   }
>   
>   /*
> - * After acquiring lock with fastpath or when we lost out in contested
> - * slowpath, set ctx and wake up any waiters so they can recheck.
> + * After acquiring lock with fastpath, where we do not hold wait_lock, set ctx
> + * and wake up any waiters so they can recheck.
>    */
>   static __always_inline void
>   ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
>   {
>   	ww_mutex_lock_acquired(lock, ctx);
>   
> -	lock->ctx = ctx;
> -
>   	/*
>   	 * The lock->ctx update should be visible on all cores before
> -	 * the atomic read is done, otherwise contended waiters might be
> +	 * the list_empty check is done, otherwise contended waiters might be
>   	 * missed. The contended waiters will either see ww_ctx == NULL
>   	 * and keep spinning, or it will acquire wait_lock, add itself
>   	 * to waiter list and sleep.
>   	 */
> -	smp_mb(); /* ^^^ */
> +	smp_mb(); /* See comments above and below. */
>   
>   	/*
> -	 * Check if lock is contended, if not there is nobody to wake up
> +	 * [W] ww->ctx = ctx	[W] list_add_tail()
> +	 *     MB		    MB
> +	 * [R] list_empty()	[R] ww->ctx
> +	 *
> +	 * The memory barrier above pairs with the memory barrier in
> +	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
> +	 * and/or !empty list.
>   	 */
> -	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
> +	if (likely(list_empty(&lock->base.wait_list)))
>   		return;
>   
>   	/*
> -	 * Uh oh, we raced in fastpath, wake up everyone in this case,
> -	 * so they can see the new lock->ctx.
> +	 * Uh oh, we raced in fastpath, check if any of the waiters need wounding.
>   	 */
>   	spin_lock(&lock->base.wait_lock);
> -	__ww_mutex_wakeup_for_backoff(&lock->base, ctx);
> +	__ww_mutex_check_waiters(&lock->base, ctx);
>   	spin_unlock(&lock->base.wait_lock);
>   }
>   
> -/*
> - * After acquiring lock in the slowpath set ctx.
> - *
> - * Unlike for the fast path, the caller ensures that waiters are woken up where
> - * necessary.
> - *
> - * Callers must hold the mutex wait_lock.
> - */
> -static __always_inline void
> -ww_mutex_set_context_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
> -{
> -	ww_mutex_lock_acquired(lock, ctx);
> -	lock->ctx = ctx;
> -}
> -
>   #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
>   
>   static inline
> @@ -646,37 +716,83 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
>   }
>   EXPORT_SYMBOL(ww_mutex_unlock);
>   
> +
> +static __always_inline int __sched
> +__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
> +{
> +	if (ww_ctx->acquired > 0) {
> +#ifdef CONFIG_DEBUG_MUTEXES
> +		struct ww_mutex *ww;
> +
> +		ww = container_of(lock, struct ww_mutex, base);
> +		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
> +		ww_ctx->contending_lock = ww;
> +#endif
> +		return -EDEADLK;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/*
> + * Check the wound condition for the current lock acquire.
> + *
> + * Wound-Wait: If we're wounded, kill ourself.
> + *
> + * Wait-Die: If we're trying to acquire a lock already held by an older
> + *           context, kill ourselves.
> + *
> + * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have to
> + * look at waiters before us in the wait-list.
> + */
>   static inline int __sched
> -__ww_mutex_lock_check_stamp(struct mutex *lock, struct mutex_waiter *waiter,
> +__ww_mutex_check_wound(struct mutex *lock, struct mutex_waiter *waiter,
>   			    struct ww_acquire_ctx *ctx)
>   {
>   	struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
>   	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
>   	struct mutex_waiter *cur;
>   
> +	if (ctx->acquired == 0)
> +		return 0;
> +
> +	if (!ctx->is_wait_die) {
> +		if (ctx->wounded)
> +			return __ww_mutex_kill(lock, ctx);
> +
> +		return 0;
> +	}
> +
>   	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
> -		goto deadlock;
> +		return __ww_mutex_kill(lock, ctx);
>   
>   	/*
>   	 * If there is a waiter in front of us that has a context, then its
> -	 * stamp is earlier than ours and we must back off.
> +	 * stamp is earlier than ours and we must wound ourself.
>   	 */
>   	cur = waiter;
>   	list_for_each_entry_continue_reverse(cur, &lock->wait_list, list) {
> -		if (cur->ww_ctx)
> -			goto deadlock;
> +		if (!cur->ww_ctx)
> +			continue;
> +
> +		return __ww_mutex_kill(lock, ctx);
>   	}
>   
>   	return 0;
> -
> -deadlock:
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	DEBUG_LOCKS_WARN_ON(ctx->contending_lock);
> -	ctx->contending_lock = ww;
> -#endif
> -	return -EDEADLK;
>   }
>   
> +/*
> + * Add @waiter to the wait-list, keep the wait-list ordered by stamp, smallest
> + * first. Such that older contexts are preferred to acquire the lock over
> + * younger contexts.
> + *
> + * Waiters without context are interspersed in FIFO order.
> + *
> + * Furthermore, for Wait-Die kill ourself immediately when possible (there are
> + * older contexts already waiting) to avoid unnecessary waiting and for
> + * Wound-Wait ensure we wound the owning context when it is younger.
> + */
>   static inline int __sched
>   __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>   		      struct mutex *lock,
> @@ -684,16 +800,21 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>   {
>   	struct mutex_waiter *cur;
>   	struct list_head *pos;
> +	bool is_wait_die;
>   
>   	if (!ww_ctx) {
>   		list_add_tail(&waiter->list, &lock->wait_list);
>   		return 0;
>   	}
>   
> +	is_wait_die = ww_ctx->is_wait_die;
> +
>   	/*
>   	 * Add the waiter before the first waiter with a higher stamp.
>   	 * Waiters without a context are skipped to avoid starving
> -	 * them.
> +	 * them. Wait-Die waiters may back off here. Wound-Wait waiters
> +	 * never back off here, but they are sorted in stamp order and
> +	 * may wound the lock holder.
>   	 */
>   	pos = &lock->wait_list;
>   	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
> @@ -701,16 +822,16 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>   			continue;
>   
>   		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
> -			/* Back off immediately if necessary. */
> -			if (ww_ctx->acquired > 0) {
> -#ifdef CONFIG_DEBUG_MUTEXES
> -				struct ww_mutex *ww;
> -
> -				ww = container_of(lock, struct ww_mutex, base);
> -				DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
> -				ww_ctx->contending_lock = ww;
> -#endif
> -				return -EDEADLK;
> +			/*
> +			 * Wait-Die: if we find an older context waiting, there
> +			 * is no point in queueing behind it, as we'd have to
> +			 * wound ourselves the moment it would acquire the
> +			 * lock.
> +			 */
> +			if (is_wait_die) {
> +				int ret = __ww_mutex_kill(lock, ww_ctx);
> +				if (ret)
> +					return ret;
>   			}
>   
>   			break;
> @@ -718,17 +839,29 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>   
>   		pos = &cur->list;
>   
> +		/* Wait-Die: ensure younger waiters die. */
> +		__ww_mutex_die(lock, cur, ww_ctx);
> +	}
> +
> +	list_add_tail(&waiter->list, pos);
> +
> +	/*
> +	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
> +	 * wound that such that we might proceed.
> +	 */
> +	if (!is_wait_die) {
> +		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
> +
>   		/*
> -		 * Wake up the waiter so that it gets a chance to back
> -		 * off.
> +		 * See ww_mutex_set_context_fastpath(). Orders the
> +		 * list_add_tail() vs the ww->ctx load, such that either we
> +		 * or the fastpath will wound @ww->ctx.
>   		 */
> -		if (cur->ww_ctx->acquired > 0) {
> -			debug_mutex_wake_waiter(lock, cur);
> -			wake_up_process(cur->task);
> -		}
> +		smp_mb();
> +
> +		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
>   	}
>   
> -	list_add_tail(&waiter->list, pos);
>   	return 0;
>   }
>   
> @@ -751,6 +884,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   	if (use_ww_ctx && ww_ctx) {
>   		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
>   			return -EALREADY;
> +
> +		/*
> +		 * Reset the wounded flag after a kill.  No other process can
> +		 * race and wound us here since they can't have a valid owner
> +		 * pointer at this time.
> +		 */
> +		if (ww_ctx->acquired == 0)
> +			ww_ctx->wounded = 0;
>   	}
>   
>   	preempt_disable();
> @@ -772,7 +913,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   	 */
>   	if (__mutex_trylock(lock)) {
>   		if (use_ww_ctx && ww_ctx)
> -			__ww_mutex_wakeup_for_backoff(lock, ww_ctx);
> +			__ww_mutex_check_waiters(lock, ww_ctx);
>   
>   		goto skip_wait;
>   	}
> @@ -790,10 +931,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   		waiter.ww_ctx = MUTEX_POISON_WW_CTX;
>   #endif
>   	} else {
> -		/* Add in stamp order, waking up waiters that must back off. */
> +		/* Add in stamp order, waking up waiters that must wound themselves. */
>   		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
>   		if (ret)
> -			goto err_early_backoff;
> +			goto err_early_kill;
>   
>   		waiter.ww_ctx = ww_ctx;
>   	}
> @@ -824,8 +965,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   			goto err;
>   		}
>   
> -		if (use_ww_ctx && ww_ctx && ww_ctx->acquired > 0) {
> -			ret = __ww_mutex_lock_check_stamp(lock, &waiter, ww_ctx);
> +		if (use_ww_ctx && ww_ctx) {
> +			ret = __ww_mutex_check_wound(lock, &waiter, ww_ctx);
>   			if (ret)
>   				goto err;
>   		}
> @@ -859,6 +1000,16 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   acquired:
>   	__set_current_state(TASK_RUNNING);
>   
> +	if (use_ww_ctx && ww_ctx) {
> +		/*
> +		 * Wound-Wait; we stole the lock (!first_waiter), check the
> +		 * waiters. This, together with XXX, ensures __ww_mutex_wound()
> +		 * only needs to check the first waiter (with context).
> +		 */
> +		if (!ww_ctx->is_wait_die && !__mutex_waiter_is_first(lock, &waiter))
> +			__ww_mutex_check_waiters(lock, ww_ctx);
> +	}
> +
>   	mutex_remove_waiter(lock, &waiter, current);
>   	if (likely(list_empty(&lock->wait_list)))
>   		__mutex_clear_flag(lock, MUTEX_FLAGS);
> @@ -870,7 +1021,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   	lock_acquired(&lock->dep_map, ip);
>   
>   	if (use_ww_ctx && ww_ctx)
> -		ww_mutex_set_context_slowpath(ww, ww_ctx);
> +		ww_mutex_lock_acquired(ww, ww_ctx);
>   
>   	spin_unlock(&lock->wait_lock);
>   	preempt_enable();
> @@ -879,7 +1030,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>   err:
>   	__set_current_state(TASK_RUNNING);
>   	mutex_remove_waiter(lock, &waiter, current);
> -err_early_backoff:
> +err_early_kill:
>   	spin_unlock(&lock->wait_lock);
>   	debug_mutex_free_waiter(&waiter);
>   	mutex_release(&lock->dep_map, 1, ip);


