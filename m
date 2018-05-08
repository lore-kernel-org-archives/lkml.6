Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbeEHRgH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:36:07 -0400
Received: from mail-db5eur03hn0243.outbound.protection.outlook.com ([104.47.10.243]:9344
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751723AbeEHRgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:36:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Tue, 8 May 2018 20:35:51 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Thomas Avery <tavery321@gmail.com>
Subject: Re: [PATCH] KVM: hyperv: idr_find needs RCU protection
Message-ID: <20180508173550.GD2184@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Thomas Avery <tavery321@gmail.com>
References: <1525713900-26152-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525713900-26152-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0011.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::21)
 To VI1PR0801MB1983.eurprd08.prod.outlook.com (2603:10a6:800:8a::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1983;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1983;3:iCGkanRPiI9m610Bn1oBiXVfv7cl31GUP31eCDEsV7ah+LOER28vIcS5CZfH7MxKIUZVs66DcdriL9I25QhIvkQHYtW1TEIXCoTiOQsqGsGlECzogv/l5HEtPR1hTNPvAanFOzuH4wlvGJ1Dm90ygAEOImxzRBwUy6RdPvIT/0EkcDH9m8iycBCKa/9rEouON/1beQ6gZEkaq08YfMZ6FQtNuKmPSMHAxyNzBXqBFA/PLZSgbs5mHcGbNA3gxKAw;25:+SbWZA/D2dlflIAm8URbnnJFaBINdiKKS9yPTBgTzaKACrZ37+5WKRCRWvIO8uvHFq18Vu9f8vWKz7rPxohq4rxyP/RQ6E9E9aCFmSHDBwszBtz2pTJvjJt73KqKKyYkX+IN0rdo+bytj2uUPQ1bbhzZE3yu0a6n1cwPtppoo/v59KBUgJaDYP1mlFh7SpUl8oZDVjXWgNL8hrUvXhxxJJN0eWDEb0GxZ7WFNqdsi0gIvj+MpgzoGIDkoA4u+5TQ8kR3fFe41LVOKWCvKKmd9+8L6+VewtAqhCo+XUYRf2xijDkWfv6BhrC565vNVWjaaOkAZUNAL699hGr3NyrYjA==;31:IQ53B4jB7NxSzk1hvjICvebMWOCi9dE6h+bW9PpjhhfGkmQFg99zloOVXqrkplA6MUsQfKorXKpsc6k4Xj47QSDqPiDCDMjimM8No3hqxHP4F7ISZ/8hX+XjL45jxmANci42QGi/CMt+PgG+/TNzKsNxTIkVpXze2LnLhEP7CWKkI4RAVFL85i5fZuw1lnZEWIuZEqYFGMpvF5j09OJzqs54SLknKdye3mD7qVj75n0=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1983:|VI1PR0801MB1983:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1983;20:cBYueuHY1FSkkAQNhhKlRq6RfAX/aghSQXC14F9EOCdD/n4HEqYVsUhyOTkK3uDvSMecJ2btjM2JBiaNwEIWlICwAlIt5ppvx0/lUhnOsy+QWVdFFQeO6VWEi7pPByOXh2nkwsdN9puhQfe5GtAoMsx3P9ClFONyQbNSpXUoVHnS9yz8ZnSMhadnkeD9lvHiBJh3QojK7MqoNv18S/+yABJy8jn8DVWdIbUv0wW86k38sJkBzw4UB/Tj/2Mh653yHDIsqnZne2A90hzgEVchd+018mqii1y3iVzV82ksV8KHokHxIlp8lBZI2T7FxqZn4WNwVcnlHudMKxOPpk8AOldWgdYtKpDW8RYFwYtaXGhI5cSVlnMXeW657WPk631I+rCSEaEvjuxPOkjz4UVdjCqhkfKeWIrLBa10HiReDkbyPtoJ5hZIi4/Aq5podJtwRLAMY3oUMs/FRUIXrNJ808QoFngaak9vDmOA0XfmnH1irgmS5TOhPg81Ruwwhw5J;4:eL0G7IeR5d6n/Qk9lSuwkCsZPKXS6JD+Xhyip6LDQRCwAGF/9oZsx+ovrhPvQBfowri9ILKJx+6RsD5D2NOkv9cw+BtIUiQca6vG/AElJbnPN+B6qnUuLTyMRzSsYshhPTf0sMK7+AsRCSHMV4fWyplj9/HSKPYf9bgRpKRDYoGgVDzWBp2TxpYwa5NrP4zmYledbxxSaYkQyuISDF8kzbAPe59FrH2/o4dtZPdABmK/aqhBjk8t46jkck3oWtRP416/tW+AVFKKJrX89o22yQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB19838D838D21E917025AFD38C99A0@VI1PR0801MB1983.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0801MB1983;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1983;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(396003)(39850400004)(39380400002)(376002)(366004)(346002)(199004)(189003)(11346002)(58126008)(53416004)(9686003)(229853002)(4326008)(186003)(97736004)(47776003)(6506007)(59450400001)(1076002)(2906002)(26005)(23726003)(52116002)(16526019)(55236004)(39060400002)(386003)(305945005)(6666003)(66066001)(16586007)(53936002)(316002)(6246003)(55016002)(7696005)(68736007)(76176011)(69596002)(6916009)(36756003)(7736002)(478600001)(86362001)(33656002)(50466002)(8936002)(486006)(105586002)(5660300001)(25786009)(446003)(106356001)(6116002)(3846002)(81156014)(8676002)(81166006)(476003)(956004)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR0801MB1983;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1983;23:rFxcb0NhG0mFE0gKrTz1AKUxxEXrOw1LUuPv4dX?=
 =?us-ascii?Q?5uWl57aHfT2naaHnZTtjGmh37xPzwZJOewL8S6Oxq+fifkIWZd96X2ErXf5l?=
 =?us-ascii?Q?cGnVqZHWFZ7lLW/yre03G7UpYBJV3VJP4+m0vjAdzi9s1H5YhKlX/cyMwsz7?=
 =?us-ascii?Q?wvIvNTrnEb3klX5bMP0RmbDyT/oDmqL5ZmR90Fyb2inmEr6LrrEZqmejTlMd?=
 =?us-ascii?Q?d3tDXPfOG9FRWXBokqJkSLchfv6fPkRvgezjlyoLyV7V9AiUm2rVXEuZAKPj?=
 =?us-ascii?Q?0DLMGrM/1VrjgAlmX9t4/LVwocjp/pRbmJ/mLCqw5V2TkugP8hiVTIafrtEV?=
 =?us-ascii?Q?AkmVFRB7m4MMHVwFBR+wzskNVmhp/43v19qXQHkqdv/ozp9GZOaPPZZWR62s?=
 =?us-ascii?Q?IkvMJXinco2Xrdz8eUzpa+ajEjzauPSebOEGfXRBhbT0Ra/FPEKAmld7kXvZ?=
 =?us-ascii?Q?1LOdb5JoF9P7SGzO10Y7Xj7DQFAZ4LZuTS156mIqsyAUzHduudIEHNGS4pSX?=
 =?us-ascii?Q?+yTeQ8d7DSYPM/cexIp7LlYVYHV3zFqY+rQsMqL41nRnb2jPlB30Br+nLPf8?=
 =?us-ascii?Q?/VBV+qcKp/UOlKLmEpUZqWsNNbPpcPb9jV/jasEA3oH9sfgbBXgGrLo/e4op?=
 =?us-ascii?Q?q+AkOuVO+4OzN7EnIUadxBfdUfQ8ZbaDbLEBqfT3dUI8MaQTzo51Esi0qMxO?=
 =?us-ascii?Q?APB0mZ0+M+RjIFMEcR5cUs3f+6pVYshXamV7b2j2rm3Qi+BagwXt0KacfBlx?=
 =?us-ascii?Q?qpNL782UwUwXParZSEKWt7jl7NODOF2caHmNoqG4rZwRs1Ni+Avb9UvGX2eW?=
 =?us-ascii?Q?cMpa9CPfS3jBMZoguuq0W3Ful17uYUFHmmaVUx8goyVcl7Rqs6IaofNoSfUq?=
 =?us-ascii?Q?ajMwmlEBkxnNHN8INYlLZlBcq32QC+NtNtWxtQpPK03r0M6hFO8hCX7xBSgc?=
 =?us-ascii?Q?9lJYTHRCVHS86kRtumy5EBp3rYCPYfDUbB1d27e+F+xgT+vf7/AuMOtqhsxi?=
 =?us-ascii?Q?iRSTosMbc/6jDjqJ39yNb3wiNTvQJrhkzDQb5+/zChv/E0CQTVO2oPBU2Tna?=
 =?us-ascii?Q?7sDd49SH8DIrjwEiq9+ToVGB8ic5TBp8X6tMJosFfi/W6YDUtTdrggGx5JiL?=
 =?us-ascii?Q?fOx+UcJU18ZPT4b5XBEzyWeXLd6znefYC3ZySxHV0y4UcgIatG7THaQS4qrx?=
 =?us-ascii?Q?6o8gCCdooUzn7sS295PPFdxOg9yeKVBjZKfxPFzrVFIy4832yYjOfv8w7BWE?=
 =?us-ascii?Q?1cMkG2XQ0LnTejCTUFFnYHp6CkIk5hQdNiYlXJJWInKTAhSJmElpiQE5k+Ok?=
 =?us-ascii?Q?/2BZFsZwrBVhT0p9UBUJoG0zLYp2eR8ROZ63FQ+RwVRZLXsoSAQPKx4qy6eI?=
 =?us-ascii?Q?G5Atfc7wkIVXKdHG+jmKY+et+N12cTtM5mb2whURLYK09RmEDwS/1pgFtwqY?=
 =?us-ascii?Q?kYYUb6EinDA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1983;23:PlkwlVLPVKOQl9I/v7pB6NiKUMOPhF7A3NLeCvfXzTFdm5EBBPeP7XShfCplanl652Uz4PFJDo6He1mA5dWrHh0thD6JKlK5pnud8/CJS63Dxo7eUFHYbiPS2diZebt2WWArtJheWcfJvK0gCbrcCw==;6:j9lImiF2RX8x02AhnXSwLbcWJU6tYdmQ8HtHrS7RLrABpAvvwUJchXDAn0EGJI1EjdngXoR7fMkLOr7lPicKtTNYkHA3hdn1B+jK4w1GHmu96VIl8Hnuci9nxcZwx0/mW8aOAbtsfK9xx6Pv4t4ThDOiAzp/c2DGp/VPy05X2GmmsohB1KSfDgL71C8mZw2VkEFNgjkS4ujZB+Of54Ls/M9xZiVUEihcHz0Mu3o15MKMNkcvNLmFTeySCCAIZvlmztTd+YYdwBsJo5rTJDZVaQe0AxTzW+vEcpHs4P562yiYr4tjx1tWZzwooBX1tthACMVFbOhLsEg/cZL0I9v6YecQ6c4BgzAz5U6snlKHJgu4rFix0RKlKcHJlFfOC/a2/pO4eyPTPTg1zgUeUhNfmi19Xa55Jw5qa3FuQHSIz24+ILFCIHnuQHI0in63PzB/FFgTAPcfuYyPShc7aO2PjPSlj1xzy0WgYGwvOc2f6+5kNvBfdzLh/mKZpGJ0pIkh;5:c/ja8rATu4OYM1tTNDH703l8/DIzQXKTkGHIiezUNXG3o109Afv4Y3EPwVw3ILyWJ4cDjfaqhGk6fufBGd3bwZl3E7agtn/sXanjJeR5c4SPQoyyeXyPUaXz8p8e7652sBOFAR2QLxKIuEgrsArXvbysdRrAV5xxek4w6FgJg1A=
X-Microsoft-Antispam-Message-Info: NW0nptEHt+uiYIwL6FKmpxadUZc2r8EAGS0zQgtPqebPmVtNaDtaA1EQmKaG3Vw5p9Y4H+5Nl1LzeoGN3ClUPnAy8CM4kojfyigL45QmzS1T5qp137pInn0HaavgLxyAtYSxPD+R/zAE1OSVfAbYiNCP5B0+0nPe701CHOyBi68DBwOb2qtiqGA1XomrgfQVaJEG7AxO/cBGow88CvGhYFVrTTesrffM+FKW1i4fBPdyy7vU+g9cjYhdo49UbWqId2Q1TPJPZnriTxHfAkAevIb5eUR/OA8Zg5B3IhWZxuFC+MdqJSwANDX+qSjDRADxoZnV1CfhykUXw2AMy2PmbEcNXnZ54ghKi6bPiE2qdy/FqW8Q4I7qn0Z4s8yPRlL8oa/tpL6J2CTEvv82WCdJ+Gpn0Q5EJPTF4zJywsyxfos=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1983;7:/sMQUkHIIuhTDfqUQpXAy1K4TNsN1XFiXC1FMCTxCFQQkjh/8nbbvNm74MWt0ybhOb6xrk6+s8/xItykqJIGpgT8ouVtWAZ9SPVCeAPIBmqaijq2hFRe1yCJIFUphtumiMcNUfMJOUk+SUdwBfnU9KHvZ5KveC5MF5j4H6gUBKxjMxLH5i/Bb/Ynpvy1sf7m9Aa3nz0yuLYiOF8HpSDzV/0K6I+a6vNDHHYy7hRYr0MxW3McGc1s+4Giu0Q+PeLL;20:u5iCxosiGXn9TtMYMLP65THK2GLu6DrC30RgfVu6KZKjW+Yx2fposq8tr2dgcwHNXf3PermBednY9cxWRVaG5zQ8LxU3KgMzSkks4SordgdqsA8cAnGCST2/C7dA+RP/O1A487femURm77d9dds5i296zzx05K4WEfMPVU8PxWs=
X-MS-Office365-Filtering-Correlation-Id: 3a4e8e55-5bef-4406-9378-08d5b50a2723
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 17:35:54.9361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4e8e55-5bef-4406-9378-08d5b50a2723
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1983
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 07:25:00PM +0200, Paolo Bonzini wrote:
> Even though the eventfd is released after the KVM SRCU grace period
> elapses, the conn_to_evt data structure itself is not; it uses RCU
> internally, instead.  Fix the read-side critical section to happen
> under rcu_read_lock/unlock; the result is still protected by
> vcpu->kvm->srcu.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
