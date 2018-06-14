Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C0C1AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D356208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="I54W6YWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D356208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755078AbeFNMsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:48:39 -0400
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:25312
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752767AbeFNMsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KHGN8iKicFMKb2RLhj5nRvgb64DOEcTtLMOvvdzmhg=;
 b=I54W6YWfAGYpb/JKCBu6r4rFL+0+uhtJhmhHMsKYR7HykEe87Q1lqICPxqjIPO2rRxLLrDD8u07QEhPjRPgsS8AzuElKMLAWiXzqjMPSv47FKJ/M1BPybZew3qSnQPBYoqSIDGsnlw7Aqwil+2ufuxYMWY91njCkhWwNcFdBpo0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 SN6PR05MB4589.namprd05.prod.outlook.com (2603:10b6:805:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 12:48:29 +0000
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
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
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com>
 <20180614124129.GA12198@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <3d73590a-13de-9164-4b32-9d7da6a1055b@vmware.com>
Date:   Thu, 14 Jun 2018 14:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614124129.GA12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::31) To SN6PR05MB4589.namprd05.prod.outlook.com
 (2603:10b6:805:38::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168edc8b-98ed-452b-c3dc-08d5d1f522f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4589;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;3:hLqj93hfNTZpqVjnq/nz6wba/qrFb4Z0q2CCiSr/9GvQHjhMG7aJ+c1XupdyLEz463K/omjW4Bve2cvi/VhSjCUULwl5HFKIHln3lpO0NNtzJHPEGoMbktOy22eJPZ8w6ZpMjstYSZkcur5CFp6/yf9WOzdGxAnkRCWUyNifHMqQL7yJUtYMoWKtuyidaRTJdBtxoH0dCMsEZ5ciAe02wIsntFXTla8iW5Am/MriwQRx7KpUT1WqxshQKpThZUS9;25:2XPgjTkrDnYsyXNw+ClOYYmUar+GkS67gwzu51hHGNPY3wp+LGux1nDgZOIYDDaLWb5rIG8bMIo/lxUKvuG3DSjmOptwV6J8iPdkvvGgj4HZ4uGPKi15f+jDxxg3qxeXYvBvOJuVYHkhKg5bwpQhuv7XtXYL0AF79qEtqb0kMFih8cp/pih1pxAUusV0TwTrQ1ln6l8dgdGyt+VPhbX6u39mQabyLU8GYcsIVUGHxzeJ6kGXNmgYKO2VQxsK0cIhCft9i1iliUmziwMPpDhONzUsGJW45/RLCJiN+Yl3vt8yp/o/2BieYc4kkGWWyMCwLf+7lkHodmxkXPBXBMWvZQ==;31:YSMMdU59x0XwTappaLOrpS3iomRl/9Kkd2D7gcD4Zb/iGYASwWZfo4NiI+783DJVE+omBVksHL8tLfkPkh+/7ZJRbSXbUKWtrfWp9YgZPRbgZ0dffRhqfq+9ZHa5nmh2ByO1MpWwETBbihqbuPHPlYJblrd9Xm9/eZZl1dtwN747Q62NtIHw4GfUsw3+B/pvHdYpHTFMYyOdI9tEbYrgDT+amLufOgVfacsWnrpBD3Q=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4589:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;20:YRf29rib/fRYXAQcUGLgJU9mgGdCzMQ2rRma8j5/XKWW2bt08S/ebl5Y+rOW/Y+K0hBS61za14TjUlrlQOL3puEc1sWJ5/SxBp3y5xZ+gPbmWvhcpLX2+NW3L+cvQlvRSQam0euMWhOLUCuigZngqkGQIxOEijdbMp4yA5Gyenc0/bvBoqVOM4nL5S4XhXkmu3hoUMc+llKHc1+Y+hsG1Ide+usSirkSRvMlbwoxBDojX+jeo8PEfFK7iBmUcwQUzUwotjpqeNgh8sbbNCKhsyqgCdyWuzgbD+xeb0XwyviFx46K42PS+oDnOqHLtNXtWcqhmW7TG1o/D3wjYBcP17An0UP16w6u4cYmYooTfonOX20GXDM6riaMOtqCW1loAr6CRvIQM8BlVbPSB63NIVXUzcNpmWhHs2cPV2Yttc3iUxwkhrNdi51O32UneGwYfQWt96aGYIUXLDrI3nw7E4LTNcXUt/jWMDv4Axwko3MUYoXuAnkEeFResmLYmcpt;4:/uoWOu54KfPdO6RQU4n+MIWP6TAbuOXj/gyV8wfzU/WAjDWx+qtK4dbOHMWormwuyr4XJ0wvddAV1LqhprY6paUSRjnaoKf/3kZgcBMd15Q+4IFFAFqY1iYyaaWvNxXGrVJOxmVu/H9U3Y1d6GaCjDj3VZc6Jgp7tolSknyb9yyi2+OAO15EmaHYop8DZEjSaKJefHNivpng04RGDh7B00ipjUlxDV7TuDbobvpYxM7np8Yp43OD0mXaxiUEsTINr4zKOw5NREltlnm2SBjT0w==
X-Microsoft-Antispam-PRVS: <SN6PR05MB45891214C3280B60B5D9D0C7A17D0@SN6PR05MB4589.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4589;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4589;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(396003)(376002)(346002)(366004)(189003)(199004)(53546011)(76176011)(31686004)(4326008)(97736004)(65826007)(26005)(53936002)(386003)(105586002)(186003)(6506007)(68736007)(106356001)(5660300001)(230700001)(2906002)(7416002)(6246003)(16526019)(25786009)(47776003)(66066001)(8936002)(6116002)(65956001)(3846002)(65806001)(59450400001)(64126003)(81166006)(229853002)(11346002)(446003)(6916009)(486006)(305945005)(6666003)(2616005)(36756003)(8676002)(7736002)(6512007)(23676004)(58126008)(476003)(6486002)(86362001)(956004)(478600001)(31696002)(50466002)(316002)(52116002)(52146003)(54906003)(2486003)(67846002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4589;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA1TUI0NTg5OzIzOlRuZFRBNWdJdjVFU2t0WVowOTFzVmxhNFpW?=
 =?utf-8?B?OTJVOEp1U3FiZkxWS3FQcmxvSjZWL3gzWlVYaHNpd21Tb1ZlNkZINWFOU0VS?=
 =?utf-8?B?T1VXbkZRMkVnU1hVcmxDVVR4cDh5N0RBZWNzZHN0YXpwVzZtSmt5a1IrWlpv?=
 =?utf-8?B?cWJRSDhSTWpWSkhsNCtPNFA4OTlzSzR6VXRqcEFWcHd4T3ZlM1Fqc2w4WTND?=
 =?utf-8?B?Z3ZZYWJMMFFVYU41VG5wOEZkeXl2b1d5U2g1QSt3U0w0WUd2c3J5WTh1SkFV?=
 =?utf-8?B?blg5SmlPK1JQK1lUNE1mY2QzZFk0UHlBRStNYlFCb3c2bldOQ0IxbUV3OHND?=
 =?utf-8?B?VEJXZ2RMVTB6YU9kRHRPZSs4VDl4aTRuSzBvaUErcTlMczZoNGd4VGZXdllR?=
 =?utf-8?B?eFFUbkJBbTFnTXZ5VFphY3ZQem1jNGI1cnN1ZlNzaldwTkcvZUdrK0M5UnZx?=
 =?utf-8?B?cExVUXhyNE9ITjFDMEk2ZjEyaTZBUVA5NlJkUjkzYktvOTM0VTBWdWFVQ2s0?=
 =?utf-8?B?NU15Z2hTN0NUd1BMbW1CeERpK1I4QXNEUEJhTkJNb0cwK0dPZXJmR1hXYVkv?=
 =?utf-8?B?YW5LVGtXdndnREIwTmRzTFdMZDAvSDdoaWF2TkJaRmxzblZRMXRaUTV0RHcv?=
 =?utf-8?B?cG0xUmNBNTg0dnpDVnJocjBjNExHQVhYMmtiRzE3cTZuRkM1bnJqbTQzQ29P?=
 =?utf-8?B?YS9IVThBdVRtUFdWMHJrNzREckZLVjMxYTZoUElJc3pTbEpCNENqZG1QSGdK?=
 =?utf-8?B?dm43QXJkOE5VY1ZqamUvTndWcFlyeDRkbDVsbXc5UTFLRVVwM0RGNU4xVEdt?=
 =?utf-8?B?SXhFSklLczl4UVhIQXU2bkdPSm1BUG5kQ2V4eURucjVVSjRjNXlDRWlXMGpL?=
 =?utf-8?B?SmVwcWRYODhNOHRqYmJ0cVFyY2l6V2JRRUVkcm1kS0hYbXdmZnJLbllQQjha?=
 =?utf-8?B?Ym1qRlhNeWM3MzJzK1NEemVaNisxZUpIYitUMzFHWDA4UGp4WWxXbjFReDlM?=
 =?utf-8?B?YklVcE13OEFPZ1FjUlFrYll0cWxLdE85STI1WDJON2J1UXEyTTRRUEJsaERw?=
 =?utf-8?B?VWpodHJmNDBhYU1JOFZiSHU5dU9SOVJ6NWZ2VEp1YjJmWXJJZDdTUzZXOFdu?=
 =?utf-8?B?WjNhbXRzYWhSK2tyblFZWFliZEROaXAwOHA0RnNrdjdyaEhBYlE5VTJTakda?=
 =?utf-8?B?dmwwcjdCbnExR1M1S0NWdWxMK2RkaitiOUtUNjE0Mm1lbmtRQnNhWUlPcXFv?=
 =?utf-8?B?YnhjTWhzK2tlb0k3bkF1U2htT2QwRzE5NERRK2hQTEhNVEV5a3U2OVE4OHpV?=
 =?utf-8?B?VFFxZzlNK01iUDBKSzc5T3F2TThxNmFiSGhrOE1SYzNiMHV0NGFWWGZhcnZE?=
 =?utf-8?B?RHZid0VOMFpHN1ZIMnk1OGpjYzZlUjFUMjc0RC90MFBqTlZRdDcrRGFKLzk1?=
 =?utf-8?B?ZGt3T2pNemtCYkJOR1ZYNFFKa1k2T0dHcXV1OWkyZUhETVlqR3c1N0JjTGpl?=
 =?utf-8?B?enRwNFQzWVZQanFPREtoS2RqRFRrSnlYQW5iUnlSOU1abHkzVnQ2K3h2VW8w?=
 =?utf-8?B?QythVHo3YmNmREtkRW52aDROSFhLbTZPM1pSYjA1MDlZek91RmpkTkpEVWJl?=
 =?utf-8?B?ZUxkYjkvUkdhZGxxaFZYSUJ5TkVBYnBHVVhsV3RiTDQ2Um8ydVgxMHJUSm5v?=
 =?utf-8?B?NjIwMldGTEN6d2xPcTVvODhLNExUNGVKM0U5S2J0dTNqeDdMbUE3cytkYlNs?=
 =?utf-8?B?aG5CdUlqK2V0ajNaSTFKNHhDZGZDNHl6TkpnZkQ4NVZKd0hZcHZmRmRBcG41?=
 =?utf-8?B?M3dnMkRDN29sSXVHQ0QzaWRXSlFoZXdHRlZtdTBYNXp6c3dEVURpdFZQMkpr?=
 =?utf-8?B?OHpIRG1ZVnpqcmJjTUo5eTlRWXp3RkZEaWdyeUNUQmY3Q0IxRGZKOWZLNkFC?=
 =?utf-8?B?L0pYNmgyUXRjZndZMTNvalgwM3BjY1l6NnJldG9wbVByUmhsdUZzVXl3T1Bp?=
 =?utf-8?B?cDF6cDk0VTMreE5hUnRFbCt0Q2psOVphQzlDNDRRZmFxcCtIVHFOR0Z6eVRw?=
 =?utf-8?Q?iA/o=3D?=
X-Microsoft-Antispam-Message-Info: DvPtVRp9x/3uJPAaatjq7cfsJKJaur1GgCI/JpHfW2Wicnew80G9gSU/6ZN0ZAERBdmhnTE0jJus9KTwIdag9MmCOudm/5YKupmv4cKKW5JyJ0Qi/7rAYp43XTQ/0nv8M70w4oPnrpkURkClG1aRXLxxTRW8ufqrff2r4mnSBEwIaHLW7+UWiHIxFjRkTqpm
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;6:sVwOe3k6jYzev/FQaSEO8q/i4E+mUuLJMUNNC7yt3i1TskVAMN4hibqZM20ycIzHATgonv3vMgQ5B+dyztIUSST72BKKEctsklispWnxZfuF9giLX/pcEdIRLYnBg41dWujEVEwAl5P0EP/v9zCruTSaIJ0KpjrDYX6qZbIegTrWVQWS04H3A0iRlcjLJVnFbzGpGClsRjJe9Rxdbdj+V2vG+6Kep7cAd/egDOL8Nb3LfuUtPQu+pjrS5MZJjI7UQzXLxr3d9TN2yoa486ykQmLo9y4Lk2VS6diA9t6yzOcJUWqHfdj7JXVyTU6zz2/Eu0zEbUTgTcMAT0UsGu0l+MbOy+ap8ByMymJ0ldddQblYievr01iuic6lchAmhy+AW7GbSUIXjxo/19tFlpH57Oad3ps5WA1zJkqzyhtHKVfvRsAgoddJ3okJoaoRC8oxVUjJ6A+v7N709Cq1rJ44Og==;5:on2NwjSE/ClIlPk8p7AP6vOqwG4KLDpFvryjaI0jwMLz8I6wom+SsQwdu0/CF6vR7ttWQhbI8bQGSXSYYZqE2T/k7HhniK7zw2AuO9QvpdxKTl8Wg5IWtQedBCr/IhVMKP33zUGrHIfkWBcZv7+KqxAi6TMog9/MNGqYrcH6NqE=;24:Gb7gqvrhe0kd2jSpHlZCIZPZctqcyfOWT+hvEqxUZX2GR2SyTm/AHEBQow7XrY9PuSrY+PmAmIINHuf8+Pfd5qS94ZOAaLdMyVR51cBDqgM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;7:86RyrdtQZ+qhRHWdqlr2VapPaKL2lw9QHwRqRNXQRG1sigK7uGeIJnO0F3ZOHaobMD7oNI+P4dwZFfybXxElau5hUKzMFJbjrgN3yVEI9CccRSiiDKNrYKinJIiSDyQmO7Wu/PE53c6XU4wKrZlO3e7ci/GBFnOv5+Yi0GecD7V7YRGECY+EmTeHZv/7HROQHa+emZpV7YErd9ervVBrJLyep5h8y/fV8xAboLgp/gtlnwiiCw2RaCMETNxrSd7l;20:2CqkYvln+IfReYnnOd+yGNXEscvF0senmj6+uqPLzxjF4gHOL4VWjBVBRbpLeDfq2HsNDDIQWPdmhlHNiCIwQxlUz8enLUqXd91Ix6mJgWRFGxZa1qSijNbAUM6Gmaqw+eWP0hQDhlsnUp6cBs5HSylqlXMM/iK0YUp0hYzLgf4=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 12:48:29.0801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168edc8b-98ed-452b-c3dc-08d5d1f522f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On 06/14/2018 02:41 PM, Peter Zijlstra wrote:
> On Thu, Jun 14, 2018 at 09:29:21AM +0200, Thomas Hellstrom wrote:
>> +static bool __ww_mutex_wound(struct mutex *lock,
>> +			     struct ww_acquire_ctx *ww_ctx,
>> +			     struct ww_acquire_ctx *hold_ctx)
>> +{
>> +	struct task_struct *owner = __mutex_owner(lock);
>> +
>> +	lockdep_assert_held(&lock->wait_lock);
>> +
>> +	if (owner && hold_ctx && __ww_ctx_stamp_after(hold_ctx, ww_ctx) &&
>> +	    ww_ctx->acquired > 0) {
>> +		hold_ctx->wounded = 1;
>> +
>> +		/*
>> +		 * wake_up_process() paired with set_current_state() inserts
>> +		 * sufficient barriers to make sure @owner either sees it's
>> +		 * wounded or has a wakeup pending to re-read the wounded
>> +		 * state.
>> +		 *
>> +		 * The value of hold_ctx->wounded in
>> +		 * __ww_mutex_lock_check_stamp();
>> +		 */
>> +		if (owner != current)
>> +			wake_up_process(owner);
>> +
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> @@ -338,12 +377,18 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
>>   	 * and keep spinning, or it will acquire wait_lock, add itself
>>   	 * to waiter list and sleep.
>>   	 */
>> -	smp_mb(); /* ^^^ */
>> +	smp_mb(); /* See comments above and below. */
>>   
>>   	/*
>> -	 * Check if lock is contended, if not there is nobody to wake up
>> +	 * Check if lock is contended, if not there is nobody to wake up.
>> +	 * We can use list_empty() unlocked here since it only compares a
>> +	 * list_head field pointer to the address of the list head
>> +	 * itself, similarly to how list_empty() can be considered RCU-safe.
>> +	 * The memory barrier above pairs with the memory barrier in
>> +	 * __ww_mutex_add_waiter and makes sure lock->ctx is visible before
>> +	 * we check for waiters.
>>   	 */
>> -	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
>> +	if (likely(list_empty(&lock->base.wait_list)))
>>   		return;
>>   
> OK, so what happens is that if we see !empty list, we take wait_lock,
> if we end up in __ww_mutex_wound() we must really have !empty wait-list.
>
> It can however still see !owner because __mutex_unlock_slowpath() can
> clear the owner field. But if owner is set, it must stay valid because
> FLAG_WAITERS and we're holding wait_lock.

If __ww_mutex_wound() is called from ww_mutex_set_context_fastpath() 
owner is the current process so we can never see !owner. However if 
__ww_mutex_wound() is called from __ww_mutex_add_waiter() then the above 
is true.

>
> So the wake_up_process() is in fact safe.
>
> Let me put that in a comment.


Thanks,

Thomas


