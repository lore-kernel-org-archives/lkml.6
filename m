Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeC3MA0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:00:26 -0400
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:14287
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751204AbeC3MAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:00:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: dnelson@redhat.com, ynorov@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v2 0/7] net: thunderx: implement DMAC filtering support
Date: Fri, 30 Mar 2018 04:59:46 -0700
Message-Id: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To CY4PR07MB2997.namprd07.prod.outlook.com
 (2603:10b6:903:d0::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17b297c4-e445-43e7-6840-08d59635ce31
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2997;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;3:OenmwWC/7c8oPWwx912gbHROqNAANClm5DzN8MKESh7ZN8IqCA+uAijaZR1mqYaEZonJhxKH0+I4fREsBWW0ijMuJR9JlyjB+YiPBklfmktCgadeQbvL5kqZwUDPCboe1+vZP0H5Xfju3UCHmBFXhknBiDlLfFwot+uIirE6kLvmsVQMeZhIgOW2KSUuR+BiTN3KIw6L7+9aTsvnqo5XDGToKhe9EXmnKpYFw4u5Aq9HNTRYI+Yqq7l4YdMeSjnU;25:KYPG5VgyY4v9AZPHMeGVyq3JL8JuBcRqulp2pONSRvDi+9cxPadiQVu+QJydtC20yPZYzZBZW84ytYSengbIe1FnYFLti2KXIooMwP0p0SlBt/ImSynyyJeVZoWNDYdu4Vd9iJukcaXTm3bzVZ6W7i8X1iyCYgiFAcTDzzkZophYA19mDAKs3RdXfgTJYJLALymRsf16LAjXBpA5uGvH6ZFm5mVLXGvM3JjvTmUJDPzW1yPtbA/DipWfRNahJ53h73yWxJ7vMD979TO/6RQFd4wcXP0M9E9xu8aDbIZdXoo7Pg8QUTjDVdfchWJn4BM4FQ3r4qN9JCSfEUmbhRCn3w==;31:A/YkFmhqTeiVY4R7c3xAPE9QKWrS8uspRqoLCb82mxaTNrnKiBcdaeCXHILIYuBLSTY+y/Oe9fNOUzXQK4ofrrwULHkoNDZYcNRLVcprxjjU//Irp5NqTng36qmuH1zga1F+k0ptME39GVZ1qAv1zKqOWkOH6W0EQBmD80VYBwqF+glU1iGtvwHXMokg/7Knp54RfxzBfdbakhM/aQrr4KC4NpQUe2KsBf0nzphYSHs=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2997:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;20:T2l/3fj2xhQDIIpndGV4b8rKtRNotE97YJ/yZ8Oyi9/MvGHQL+dSHMgUUGJgmQJrMwhDfjMaCLYwQZdl9eflS0voEx2fh/pVBrkX02YosUhZ/F5w2VtxIdNSVI7gAjXNkQl8+gCfv+TdP/yeQTANu43omFNYTMtkAC8/kQdlHT2xmvN5DxUfJ/NsQM5sbEsiOtR7SWx5TBcKztFW19bc1xWXXir8yE5zJyUT/GQ8nNOteKekX1R/ax3kTPQw5YnZmTMNHHM6CokGDLvDYD1GCYWhNlhNFMuegG7ToantXUwXFWJZLMktaSAsC5KWGrunUulvqEOgPw5hpo4ANCD++B12GbNxjGX1VELJ+Ai1119M9KJcETx4N+KKxz268fA9dIE2DSQQaVBkCBc8GQCmPUaWqsH7YaE1HcD8gM3JYxP8Gsa7cOId3D4vF5qRLQ57lwxdS8WfHyNl/JvRHg8ktMwdl2pHs0I4KnBYrPBYo/D+Wnoi0VlLoL0HhWj0MuG3dA05kdcNyWdri4njvx9DdXTdY/PLhHlFySwiPz6q03lEyGb4HVgNWIHmmnC/1qOZwamNo8TUJbjyNRlTtdxTr/AMiynaNVWdl7vix4PRA1g=;4:ayyn3gqxj/g+kquIDB+S4hv2t5i53YS4CItWD7nqtskdNdopzyx0cbpw7VNL+eVEK92s0B6KWHaCRUbH304+u4wnQGBxn14CZe/3FNe75wL7k89hdGIRKBUt+TJZfG7uvKhZBRuvbnvQGmpXvUvZGsKQ/kaI+Gh2JH6z2yam5xmApVfbybmCPP8dRYIa7NzJVs/fXkGsA4p27Hcbva4NGuHUe8y6JkWEriUAigemPeBAahygfhQJdlY3OcAkOce6Ph3r+UBkIV+mwcN4ekcQpw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB29972E9509AAE3FD9B1164D58AA10@CY4PR07MB2997.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB2997;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2997;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39850400004)(189003)(199004)(3846002)(6116002)(1076002)(105586002)(81156014)(81166006)(8676002)(50466002)(53416004)(5660300001)(52116002)(97736004)(23676004)(6506007)(8936002)(59450400001)(76176011)(386003)(69596002)(2906002)(6486002)(6512007)(72206003)(39060400002)(6666003)(47776003)(316002)(7736002)(106356001)(486005)(486005)(476003)(107886003)(446003)(305945005)(53936002)(11346002)(2616005)(66066001)(16526019)(956004)(478600001)(68736007)(36756003)(50226002)(26005)(4326008)(2870700001)(42882007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2997;H:localhost.localdomain.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIyOTk3OzIzOmpBaXVYZHN5Y0RNaWwyOW9oYS8rRXM4SUhG?=
 =?utf-8?B?ZlptTHBnVDJGR1FEalBoVTdMcUpWM005M2dzTTFCdFI1Qm9FdWtIZ3ZZRWZH?=
 =?utf-8?B?M2tMeDRFUDYxR0ZpYk1Fc09Udk5WMmlQUEFoZlVoamhhQ0lpVTRuR0hOR25Y?=
 =?utf-8?B?WTdic3B5MmtlVTNXbHNOV2Q3RDdacmhFb0R0bzZYVkJTcG9vNk1XemN6NW5D?=
 =?utf-8?B?MXFvekRBMzhJWmJUN0huWDR6V211UHdsa0c2MmVIMG5NUE9jdnlyVzVXNkd0?=
 =?utf-8?B?MUhJU1QwSTN6WWRabmRnZ0Z4eDVVTUlNWkR2VHNPYVRnSFJNWmlPZHhzYVI3?=
 =?utf-8?B?N2FvdEI5ZGtvNTdORVF6dThnRWZGb1ZaelNlL3hTYmVmd1dIRHd4Ty91aWNm?=
 =?utf-8?B?NHRhaFNqQlA2aDMwZTB5MlE2WFNacXk5TVN1SWhKQzlrSi9CSzJ5eW14VjVP?=
 =?utf-8?B?NEp4YU51aVM4K21Nck1lemhRV1d6QVdGNHJTWnFDWXJ2eE1uYnpYVU9sTHpy?=
 =?utf-8?B?Zld5bFF2RVlwb2tjcDIweVFLc2doamppNkV0YWJHOXB4czJFNis5b0h2N0pr?=
 =?utf-8?B?am1KT0pvVGd3U0V1cjNoSmxqY1l1ZXpUN1BLdURUWS9udWUyVHhTZmhlbHdu?=
 =?utf-8?B?NzNWWFl4am1KUHhsemt0NjNBcTVXd00wdEFYUXUyM0RUS25VWmlBb3gyLzRu?=
 =?utf-8?B?U1FxNm1VZ2IrUUF6VTVqRWdNOGVUSytwVXlHK1RTQ3paWTI1d2o0Uy85dXBv?=
 =?utf-8?B?N3AxeVNPVEZDSG40R1dqNi9lMW5NYXcwaTkwanNVS3ZySmswYUIvSFBENTly?=
 =?utf-8?B?RnZCV2t2enBwdmxiYzJ2RDhIRnhUQ1NpRncwcThhK2NJUnQxR0tuTmxFY1ll?=
 =?utf-8?B?YjgzNURBQzRSSEVyaUZsV1M0SFVlbk9yTG5OcXJpcnNTSFZzdUY4NlRxME5U?=
 =?utf-8?B?b2FsUGNQNkl3VVpPQW5DWm9oajlBcG0rRW5lVG9UeDdjSEs4YVNPWmFyR0ZM?=
 =?utf-8?B?K25WeXBpNEQ3VkFoYkhNWFlRVTgxR1M1c0pYUXF2dnFXWXJDZi91Qzl1Nmt1?=
 =?utf-8?B?WStDTk14bFJod1lQZGdSUDBZQVM2Z0JZSzMrZ2VISEdpMnFoRWZMLzEzbmQ3?=
 =?utf-8?B?Uno2amJJd2pXVWx6L3BIR0F5cXF1eTBPb3JhbVMxMnRreWV4eDFHbCtjbC9w?=
 =?utf-8?B?QjU3bUVRRHkrRS90aS9uandEekJ1SHRQVXhyT3hsWmtyWUl5ZE1VRnNtWjhO?=
 =?utf-8?B?dkVJd0xpZnFSUEVkTnZpYUp0UnZ2QzErbWxXRzRCRVdkb2hlT3BCZFNNWEFB?=
 =?utf-8?B?WWoxUVlrTmVyOXdZVlEwT1dxNWJCdzlvUHQwdGVUb3lpQ3Z3dmcvL09xaElr?=
 =?utf-8?B?dGpMSkx6dHFIUTQzYXdaQzBhMml5Q0dFNHFpWXVxeGhBVDFCb0FyWURKMFF4?=
 =?utf-8?B?UDVmWHY0U2JtL0ljWU9oUHBsaUpBVnFXY1UxejczclVWcWhyUUp6NnhJM0Yv?=
 =?utf-8?B?SFB4QkNqS0MwSm5Vcjc1N3dIcXB4N08wTW10c3B6SDlnd3VlU1Y2WFJiRVZF?=
 =?utf-8?B?VmRlb2ZnZnJ3aVFvaWgvcXdSbGE1eENLcllUbnBEVW51N01FdEY1R3pma1dq?=
 =?utf-8?B?Vk9BMjV1akMrckQ5ZnJlS1dGYzRtcWQ5cm1sNjBud25YOHJsK1pmZ3hpMXpn?=
 =?utf-8?B?YjdLa1BSOTRDVnp5dktkb2V2WFJhWVJ1cW9ValY4QnJ6RU4vQU1XVXZrTWpI?=
 =?utf-8?Q?ZaEDRm6sjWpaUymw/wG3BNwjTxgbbizFGURqM=3D?=
X-Microsoft-Antispam-Message-Info: BWv8BedApKV/a515QGw//reC9JIv85Urkx/iQLWuMzPRvJXBApb5eHDZoqzN+pURKQCP1V2x4Rzv1d3bzjy+BULuMRViAzU9HEa1VRry5qrS/bjubXh67hPRoVQg1sBhKk5bGkftjewM3QKpZCNXn/G912DDhc5hWiFO99AUCFJ61gYiXTdteHEvY5cYHCcC
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;6:UVN5wwMdFl9xS8V5YWlDtZa2Iz1JGnzXR4V+WfQJECyOjIMXQMhLJged4PiZ/COjrunMFeRggNXzNqEYDKygWDLEgYBrXmglS/Xb92HEGzHOinDbfhoZCyVQ/UVCUQAhBWEb8E0CpbClgzxd9LfOynGcTc/tYGeyske+snBuZvwZ71SuigZV2pxBmIk/9dKCjtkgjL2TGfW/32wkN+v2+1z4bfuOCobDiqQVUa6KB7TjOowOs0WRq4dYj21wV0dtpPn21Tu1wY+AYWeDhD097k0+G+NRaA7GOAFqwr2jo9zhpTdIgZwEW9Jms0M4xKp3xD1iGQ/5kT1b+657J6gDv936grNOW3yIws9tda5J8zIK0HNcfO0kiPAeBkiBYLoLK3ldG+1BM75KRivcA60ZPMnOV68K1ojFYmrN2MSA9qknoeV9WbEywUM0yaxPsRp0Zuj3IOIVufQLuB30Mjy0yg==;5:/zpt74XX6ztN/gLr2Yl6sdn4EEly+EpfZw45fSkIjKHmfdjvWgX1Hr109A+wo7GsL3SqyAVEov3y7lYlcbG50UHJtPhgZlPM++DcrqRBaapD2IzRsgBAkeGUX2Gw1Lj4TzADciZUB9cQoxgtSZIonutr7iNyYUmLTrbh/qJFRiE=;24:paza5qLfk6G1r3dQt9Ch4qeSidKKxaW1agZybtw5xt6EfSlU/lGbCeQKRLmXdCaV6kndFMCmEFgag3ZwLbxMP1o6RTDblszsRexI/goIUrE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2997;7:etFqY79dBUsIY5yEJ+7PsEh5Y7JoPY58W0KzezJVk8skTZLixpYUWijCuwSjaf5M+SOohjlRfv131SUUD7PInDtoY8kfTD4dq22xzIqXH7VHvJ8ec9GLLB+lHg2X0OvcwKpTZSEZOQvHs6zd4bQLcmo2IvdjtE/2V7iMiVq0vwY4uzT40qXWJ8e+BX/igW7EbNw9FF5XvK/F7T3S1nXD8GVhTzB6015qBxcKidv4dPkw9UJ9ea/HVxy40By1EqfM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 12:00:17.3789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b297c4-e445-43e7-6840-08d59635ce31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2997
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

By default CN88XX BGX accepts all incoming multicast and broadcast
packets and filtering is disabled. The nic driver doesn't provide
an ability to change such behaviour.

This series is to implement DMAC filtering management for CN88XX
nic driver allowing user to enable/disable filtering and configure
specific MAC addresses to filter traffic.

Changes from v1:
build issues:
 - update code in order to address compiler warnings;
checkpatch.pl reported issues:
 - update code in order to fit 80 symbols length;
 - update commit descriptions in order to fit 80 symbols length;

Vadim Lomovtsev (7):
  net: thunderx: move filter register related macro into proper place
  net: thunderx: add MAC address filter tracking for LMAC
  net: thunderx: add multicast filter management support
  net: thunderx: add new messages for handle ndo_set_rx_mode callback
  net: thunderx: add XCAST messages handlers for PF
  net: thunderx: add workqueue control structures for handle
    ndo_set_rx_mode request
  net: thunderx: add ndo_set_rx_mode callback implementation for VF

 drivers/net/ethernet/cavium/thunder/nic.h         |  29 ++++
 drivers/net/ethernet/cavium/thunder/nic_main.c    |  45 ++++-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c  | 110 +++++++++++-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 201 ++++++++++++++++++++--
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |  19 +-
 5 files changed, 374 insertions(+), 30 deletions(-)

-- 
2.14.3
