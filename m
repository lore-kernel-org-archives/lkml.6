Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCWPUE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:20:04 -0400
Received: from mail-he1eur01on0107.outbound.protection.outlook.com ([104.47.0.107]:19840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751400AbeCWPUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:20:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mel Gorman <mgorman@techsingularity.net>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 0/4] vmscan per-cgroup reclaim fixes
Date: Fri, 23 Mar 2018 18:20:25 +0300
Message-Id: <20180323152029.11084-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0101CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::21) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a154fbc-0386-499b-0986-08d590d18952
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:OGb3A963BAUhQgemC1/7DwVRe3FclahU1CREu8JYTpSfW/GZN6bpTCDLVL9hSHgFTQcdQAE/OX4VeYoAHIl7/ENAODq4uvwH2hnnoipIpDyGUIkEsU26sS3354gruLVPOgfUhW3N1vTmQvE6swhrjQeGQA+6vik/8+zuk2z4HjkySwvdfOQxV+ILfKyY1jzJGq1FyS6GjaDPwU5vJYC0nIieXRYsV3WuKwyrVnvmOTPKWaRpsqL/NphA6dxBD8Yd;25:41Izf8xwLXXAui3oDUxRKyrCzaFJL9U5cPvL+yEh6lNsE+x3XwnkSxiH45IjmIuZ0UuHEJ0FBedl2DvupSxbDtxlTCYtjsJUYxgYNdItM/SpmUNYy7SgOwcek3qQlUwu371pXcEfXQra3O0NmOp/ENHueSMI4qinGxqADADspyNV45/WMv9xTRkD0GJ35gw0Ul1WgCjRyQ9pzluVSKzNsoPgbRF+G71rbwMbkdWQiErrEJwpkFyL4AuJT0bHn0IZxFHJBzvGFQl5zMInA4KPGBeUAXl8heCTc6KEomiS9waJhINL69PSz2/m/uRpfQiSqqB8E2qdLCWzfW8tU80JeQ==;31:2GU2DAcnrwNQZyJhi6AervQns13Ih9csvAzBWA1MkUO2jH5YzVbF4hQrEI3SsH4ZAUuEzp25AvQtaOmWXdUqcqmKtoxTWrQoIva35A9I1Gpps/T2+cMv7AV/Ph437G0/6SywsAr9D0epAqd0mGxklhf1syJLt7nJDaQrtACobf62Pwue0dvxFL49ykQcXrTfJ9ONQiZcLWV0uDEXNLrzAozJ922l2yWtZQAe++STQrU=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:vvo/xrpk7mhqg9/akFnc3A9e0Z+YPTc8Wn15oqRu9PaaYiWKH7BszdpxZAVE9KvgmWZxuH/xUUxw9trY7xhbnLn8pp/praANrfMdNuEQt0746OmMdnACABDDiPZzaBUJsGXqU6JPzp9QExTSBCrxRgu7+e1E0SPFNRGB207HmAHzHye9GMY1GHBGYJoybmJyPMSKn7j+YFMW+42xuTDnSarkykbTGuim1i2Sc1bAeF81jygqvvRQpqYZlrOMH81GRYrzc6hLlE+ColC6gEYHEZkSjzJFEPGAcKyKf/ucUY9LwX1GRFsAL05ATFmJpcekzWGzlPXSlR2MC//Wvc87h05U7jTXP1FPVNfjGFiS0EYXW+sD2tzIoLOnbIk9WA0HNKOl4qgMX+GbpN8aqVMr06sBJgcdMjxJx1hjZbVE4F45Wzw8+F1EFRHXi9ANhBbfsXPeunacec17iBFZpL72bBYsOSUGbcqwJYbLLXjVRFV/QpwC2FPMMCAZFznhkan/;4:8CliSozBgOZlhNRNzvr5F58ctN/TZE9xuC5ibOhGhKaP4nCa1qH6PHeNPELQaysZS5H91ll/Aycs29CiRO8/Hl5gc5jK0WXPRHN7MvAbWU7jkwzP18/ytr2sV4Nw5o0K5lt70Uz1XeWSKaonH7uIOeg9CG1XiHm0oPsU7Wwq72eayS2we+kdAxN5m1kLIQeaKvZrrB6v4fAHcZxiX2uwjNG1FQsDabilJGJfqbKE/ky7NNL4sOyFqC0IG1Zv6XBS8ORB3ft3TbvU15uElgLLtDOtONlnMzfcFGUGZ0iiAOjd4zjR3Fv9qePrIXl+5poG
X-Microsoft-Antispam-PRVS: <AM6PR08MB3253A6CF2D49AB9BC8C77CD7B0A80@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(39380400002)(366004)(396003)(376002)(54534003)(189003)(199004)(36756003)(25786009)(186003)(97736004)(1076002)(3846002)(53416004)(478600001)(48376002)(50466002)(66066001)(47776003)(105586002)(106356001)(53936002)(305945005)(6512007)(4326008)(7736002)(50226002)(81156014)(8936002)(52116002)(6666003)(54906003)(81166006)(386003)(86362001)(6506007)(7416002)(2906002)(59450400001)(51416003)(316002)(68736007)(55236004)(6486002)(6116002)(6916009)(5660300001)(16586007)(8676002)(26005)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3253;23:VlMrhQDTm26YfSDvu7aLvbwaSkuE+SL4k6/e98wpy?=
 =?us-ascii?Q?L/TLiBoogrXQBiXPLtsMse8YR13lRQA5IEsIOx/kBByzhKzzczCwoVQJt43h?=
 =?us-ascii?Q?sY58AGlbxD2p3QEm8Znlxg7XwrjKPfzQAwpigbkIzrDIC0gfUSgetv3FcuW+?=
 =?us-ascii?Q?Ut1hwDYBI2w1x85l0WM2tJGROPem9PZ3B7XSECmZkJwKRNGW/+4zUVQ59ALl?=
 =?us-ascii?Q?W7LqNE8PUzbUDd2eP2zFmD0gnhtlY7mlaVmzkZNiH/ReWipkD0XbSpeEzVl+?=
 =?us-ascii?Q?nPG4EBHbihuCQVvD9GAUhanKWTI1D1BVQnHWZWU/H5B2u+Jd8sVN4iX0927m?=
 =?us-ascii?Q?Yhdmmp6CW0HtvxWot0r5aXQlx335OwEbjdOEdO1eE30nLT8s7KlX5Admb0mR?=
 =?us-ascii?Q?5QbL50b79Cbb+fZZBjX+cYi0ot2ddFVKoEME9bGW4mAa3QNMHKNkstanWGfa?=
 =?us-ascii?Q?gwhZtbC0mLoRbKHi9R0sAv/d7TMerHIkbfd0lMzzPlM7fvTI3F6OL1nV76eh?=
 =?us-ascii?Q?OlU8pOkoA2ahjJsiXABcD+avC7GPdXX0sWWaiyk+uuNrTGIoqysGUqjsThyl?=
 =?us-ascii?Q?B6hxNksNSyPs4BUG7kwqyz2RwgIWNNA7J8KogvsYNgb5i/MZdh89vUkYXQt0?=
 =?us-ascii?Q?ddldo4pSUkwUxfh19pWu+x3LpKajZtDRE/AjF0oCmspCmbwnvO+yINc2735H?=
 =?us-ascii?Q?vB7WNJjHvIFd1Jkj+3xznY0ws2MKSI9untbvhDjBIPKS8/+jFfS37GRqVtgu?=
 =?us-ascii?Q?5GK/WDY5V/gyym6PLalYs1fMCJf4kTaBmKdoQRWoXGtXQDPPnfEpG9FXSOqk?=
 =?us-ascii?Q?p4fPlUYPzmRrn8LHF8qrh3Rxpbnx0t6SCLYaT+9tfPlCkpVN4kXVb3SgFpfN?=
 =?us-ascii?Q?xsExrlMdwQiXf/20Gz/Q/uaKUGNT08JvaQkqDwzSrVmfkicXt8lAeB2WjLSn?=
 =?us-ascii?Q?7NM+dB/Mgjgz6NlfU2kq0UZWSR58VJPxzPZQJzneMasYbrWJCppJf+hknGt3?=
 =?us-ascii?Q?v2lEiOTGT434ZgQzdlVsfEJlgI02nVyWLS9hFiBwgECBTonGK4IwhEBdc/QU?=
 =?us-ascii?Q?X+tx6IVud4TJ1QuUWIbx3tfeYXBRK4Vc0mLz6900CeE0NsubWBuPX8Z5M6sO?=
 =?us-ascii?Q?nqrSFTN7yNtdk6Nig+o+v0GVePlt1nD3zrBgAzKd/yFYxp08LEOCOeAG+NSZ?=
 =?us-ascii?Q?2ZejhSW94ctzivd7nmvXo4OFB7xAfhXw0jd?=
X-Microsoft-Antispam-Message-Info: SpfzcAWe2bgu4v2i2A9jB+5ZWaU4Y3c6kRI6w2w29n1WnaArobUCFjPL44yOWW+y/wmG2PRWMhVJmeZ3rNUftc2Q8HC2sr5NcAaLQLM28+qrATVZ4xKk9gr+hRuWvlBHNEyvfnbvyz6hkMn01rlnfUwCIMKzW+WFg5scBbkLOLryYli9/s73ImXxKCS6UAcg
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:FCMAojg1V23E7hNMqeuX2ezcwiv6p5kLQq4CNXbPBcZGsCMI/7B5N7Dk/vwCHSX+eD/doJQGW+Lm2UBIZ5RigxuBGGHB9yqWN+0poijgWnZkPnDU9PjdXTZT9F6oSErHvEyHCGp1GLkpbqcjbmSPOAgOMQ/ZnnUV4eU8v0VDhW1FkpSve35D/7j4RC4ls85BF+Sk0tIlQu8++rFDGqrNzYX0EfIEYvPxq7jjoo8IE+9EUh+T9dk4yUI1MgwYJnUCLk7viA+Prp3gjg3DWnn8qOWb4nirHD6gOos4bxCEEJ+6MDBewMQg+7DbPEbRmn/qn2ZyF7GR7ax64B81Rvyscs5H3UdKt4pj225pXqt5qAI0z1KKzvvDUbwKq5fbOEaksg0+8TvcUg6epRBvTh1u2y22yp8JBpM/GH4Hk+aikuEJuVNN51Y8BmoS6gLsN4vCPBWwhFMTsIrTPgiDjzgCWg==;5:RiGv6bA0Tqf/OKj9Nq/KGWJbg8AkeGu/lx6rsL+McLm0p6z8vcqgDpR/Sznfa5B/sKyfbcQq/CgSWcvcZL2CSR2HVBW+XIWH/fQfq36iBX+rndBfNWsLSFDVtZO78vkRG9Ez5pWR26yHoMOft/sWJHZjkRkaLYGpsNl4oOPamXQ=;24:knAyfYBOKMnzFJ7WBdrO5v1oIc58QUWEiT+MmSC5v7lMcV8fEOdJmXialQuVniJgJQUC+VEWxaEDaCYEzX5LCEOA3mn/4s2f9XOjBUgPg54=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:Qd2zh4inmDWbRmkCCIBvb07JB/rymcygPxRaeCIJe97872nGGCNP3+8XhwBAjQS+8ZkfaA+WX9WYWqUNMEwdrUYreJrfZ2NvDBGnH+p0LGeuxnuX5Kx+cViveTkq75lOWtA3NjR0Dg99OYkkSVPXTqp0JG8w4dqHrYwo/UfJTZtJgD3nn47N19zWZstmiQqXeWd3/CwubcDP3gDsKANUpnguvMk6NCjTXv4yCrvi5DMNmZnoT97CNVUzhcOdrG2m;20:pMgH9/6lA+kr1Hxk6enPiGAIn1DhQXm1kNEKQDq10H79zxdt2BU22Tjdzzb8dI3txVjLgYsGcyFsMnNv91efayHXFGZeMijdkhTTkhGjKcmLnqengOhqSxnGp6U1s7YxJWgSRyXInrrCSdlBx4ZMo1jg/To5RsIxlTTekkyWruc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:19:56.1712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a154fbc-0386-499b-0986-08d590d18952
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 - Added acks.
 - Dropped "mm/vmscan: replace mm_vmscan_lru_shrink_inactive with shrink_page_list tracepoint"
    patch. It's better to avoid changing the tracepoint as some people may be used to it.
    Removing 'nr_scanned' and 'file' arguments is also not very good. Yes, these numbers could
    be obtained from mm_vmscan_lru_isolate tracepoint, but it's easier when it's all in one place.

 - Compare with nr_writeback,dirty, etc only isolated file pages as it always was.
 - Minor changelog tweaks.

Andrey Ryabinin (4):
  mm/vmscan: Update stale comments
  mm/vmscan: remove redundant current_may_throttle() check
  mm/vmscan: Don't change pgdat state on base of a single LRU list
    state.
  mm/vmscan: Don't mess with pgdat->flags in memcg reclaim.

 include/linux/backing-dev.h |   2 +-
 include/linux/memcontrol.h  |   2 +
 mm/backing-dev.c            |  19 ++---
 mm/vmscan.c                 | 166 ++++++++++++++++++++++++++++++--------------
 4 files changed, 122 insertions(+), 67 deletions(-)

-- 
2.16.1
