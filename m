Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeEYMjq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:39:46 -0400
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:10239
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751923AbeEYMjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:39:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
From: Thomas Hellstrom <thellstrom@vmware.com>
To: maarten.lankhosrt@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] locking: Fix ww_mutex algorithm inconsistency.
Date: Fri, 25 May 2018 14:38:53 +0200
Message-Id: <20180525123855.28956-1-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0902CA0038.eurprd09.prod.outlook.com
 (2603:10a6:7:15::27) To BN7PR05MB4579.namprd05.prod.outlook.com
 (2603:10b6:406:f2::13)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4579;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;3:PFQ8GWSO2iRKfpeWjGmiUspffFHTQIucSgG++9qmlFvZgyfF1cveQTaX3bbkPx0s4tlIIC30wWSVhvlN1gyhs0zCzZWT3aUrvcehR0+8Vp2mXBq3G4zPEGYd/4W3z3gJxatOeftMNzlDiAgurZHiZEBhpTMeQzsStg43llAp8rqzTjUrteySnwkaaOIrQL8GzMsrF7koOFolIYIOtYiQn866Ye94PpaWSK2zznkm1vNr7x7O39IRywitRDWs+OYI;25:oOA8IuKGVD35jEJDM4Vjg9mboMnHYcvpllWNilxQ2A/05IjZBUnV1k+t/74S7xk5R4yLFWWcM/OUZ94wfgLdyBtEQzaspAnu8aDFxwZj5eUs8ymF9kNNuns1k8PnB4TZ1+qUmxiYZft7NiyVcYOe38wBGT+5Ot2fG5hni+4LpvxyLtNScF9xh6pGcSotxRER7PwO56KzD2tctGbrm14K17f8nCIWupEU/U36h3HmwffeOxuvpK2ePvR6ouqzidRgCL+kf6KEB1LxKD64N8o2zSYJIVwX/33NUjn6ubwVx4ETeSd12dYlaL3Y5aZQdKFMo2DADRYstoRaXZ3hepftEg==;31:nIP/8AJh4ir/8RN5OfeXPzzK/DzxTxjCftmDuftWxAu+CwT3tzb6MCCpBoXBhaB5LlrdbSCFi3pdMgfbJmFOocqKbpgag+nhAn7/vs2RkwK8Bl6EGRqY9HL0wGJ5fqyjzzPasNJypcVhjhYwSalTndaccrVIO820Gc+WoaV+qLv+QeIKH/5M41D+dD7j9MYcY48YaGKa7HW+/ugD1cdags4hMSL8QNpB/AvHJUuzFmQ=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4579:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;20:keefADeVjTB/DxV1PBxFtBQhhdColfEhNxZa5YI0qwF+UtZhsJDN/fmFdyrgZoAb7bfK22ayHA5M9kdGacbQ5xRBZ1duOlhPMrc4jGANQFH3/GEqR0cdQb7UDUgn7Z/ZQeHDmK5UQ1kaSvazaBuoKU48PCYBFV+JQDoQx5pYTWx/EvhljurjvLvCZwK3P+CNxhUoMsilzOUqOZaouPRCIQ3vYYGQa5fryJDXuTTou7l82VydafWa4bbv1kpVjg0rezRHOR//USZ4B0rF2srkr+hQhTrjP4QY4ZQI0P0ucFIG9rI+obMXMhHjbbNHe1fI3TNVgVKaioLzwSUFQHQZ7gUvacPsmCP8zyc1l0izyp7+xZlRUDwVYU35gExzkY5RpnQSLkSQuj830AepIqARTwV7prxn+FxRuUYds3ogDIgLFW16quu9f0qfqmqOhqis6xcGN8Khf9wF8Ww8nbZnwiWybTmbCjgkz3LBfvcp20XpDgYURdXGnolEJs87l+Aq;4:cUaZolx4VuMIxDgxuKBLWT1wEB6coFD4wW89Q1Ce/tI//khbF4wiobOcCaizks20iiidxxkJW7ow1BvLyUOefDcgwnlLd2RcCgBVYjhQQC7Nc0y3ohLBrjXBFIbMxbZHoWNpLKhqB4HrlynUdIOrc/lE7mizs/vmmp5umpq4FD22o+5ZMbcSsUqIPpOwhRdl4y/9VaFDDS9k+1WQT9JqZXWXfXXaEboA4kKQKLZ/XNz73UNfxHQGPN+CPdEclHTWeLEFLpy8P0WBI54wfX+4pvR2kokiXVnHVufdqRus8F8M8dv+yXLWi+lbN0288KWE
X-Microsoft-Antispam-PRVS: <BN7PR05MB457916D11289AEBBD61C01C8A1690@BN7PR05MB4579.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166309043207732);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4579;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4579;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(199004)(189003)(36756003)(48376002)(50466002)(6506007)(386003)(25786009)(6486002)(5660300001)(476003)(26005)(68736007)(956004)(2616005)(7736002)(51416003)(966005)(52116002)(478600001)(305945005)(186003)(16526019)(486006)(6666003)(97736004)(6116002)(8676002)(81156014)(106356001)(50226002)(1076002)(86362001)(3846002)(81166006)(105586002)(6306002)(8936002)(6512007)(2906002)(53936002)(316002)(16586007)(47776003)(66066001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4579;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR05MB4579;23:mGYVAc4EvRkLuXwn301A6g5/HPNrws7IIXtvjAPKH?=
 =?us-ascii?Q?kzQvRzuT6Q46YKwArnKeKxmZmjhgqZpA2FD4n+HDSbr0abs9v5M96gc6atW+?=
 =?us-ascii?Q?HXW1aBQkONOtmscYy3ihfQKWASltQlNi6fM0eOoXtBVH3hW9OWQ4gDujaFtN?=
 =?us-ascii?Q?+a+0Bwad1/OBt9sUVYUCdWxqAiNeMY1O4Qdg2B1XgFiuU9f3aHijjg+mqlX+?=
 =?us-ascii?Q?4YzPD5ouIGdS19S9gB+rwX/p1sdGWbf3WVMIYyPLH+BrWol4HN8/mH+jxHKT?=
 =?us-ascii?Q?VBq0EHqugIyzBlQuGwbezDvSYRNaujdvNqKR52HdJ9CmTgKgKsrs0cR4Eoq8?=
 =?us-ascii?Q?gfrTEDtScxYetI9tZpg9DqcPJFP0LfT3/Lbej/J2spZrUT2XLSUmWFOIQ3Av?=
 =?us-ascii?Q?vP6vJdpcA2ogT39hHHZ0vFn8EHxF8h5cYPzcOhxOW1vH0DSD1+5MkoChAcSA?=
 =?us-ascii?Q?6+EnuIHwcm6TbfeKto3zWU/hanDtHoy/bC24jb/E8tkiylj/RSvsq0phXIwa?=
 =?us-ascii?Q?gvTinSpEjG0ZP11Hnq89AGWPJl4vryVjTmi22Gnh6Enh4bgO+pNe78IG8zMg?=
 =?us-ascii?Q?xIcFzjMhdkH2oRJNNXvnJUwv7XE0m4d2QhovIT0sXv5+R1ISLy4uQyWYIjIq?=
 =?us-ascii?Q?gXZ5zHjC6+QP8zmiyHSs7WhYk/bS/YuGuW58Hyxfgw0WsrWH1Nm7yThQ1IYP?=
 =?us-ascii?Q?AmtgLwptXJ0mASdgzxoQHPnQh6h5/ccynojpEjD5xjVJrAd6597EQpKCXpBp?=
 =?us-ascii?Q?K5oLiP4+lZMO0hiyqPsiUTITCvPaBNFkVREl3BZxp9jcHVMMqV5EGeOxU0C5?=
 =?us-ascii?Q?/5WsfLted0mIP69Ktp53cy4LUa6/iMZ+Dcv1qUV164bq5179cz5O4gXbYMxo?=
 =?us-ascii?Q?GjHXVD7dB5l7pNULI1Uiuzn6Me3HmaE3yZBRvsaF24Fva33LlNEhKzPozO1O?=
 =?us-ascii?Q?NRd2+sZrOgqkO2B/7XIQD4bNiJtWKa7qFwZHoMiQ6eTouUJbyV+FUXfBZIak?=
 =?us-ascii?Q?YVUxJkz2PH2VENBW+r3o8F8ba5KHB0kzwlSBBLRabDd/LZy0WIYRL+hfQw4J?=
 =?us-ascii?Q?Y/9CdQJNEhh36H364hEsqsiCUV2N5o7mvm3eVFJc9gJRE8Napq6VmldBw0C2?=
 =?us-ascii?Q?92Nt+Uz13vDdcSiwdkgv51dwAsUamx2OTVQ5QpXkLLjsYlE1xscQB5VpQcPp?=
 =?us-ascii?Q?MNWDf6kS0AWpbo=3D?=
X-Microsoft-Antispam-Message-Info: rDoITzY1lPVpU7KPRBrb9s7uKszYCXo62F+riazQR9F5Fk+7qOPLrfg+vFK853pho4huYmCr0SXZYsen+m31a6fomC47L2aTzFGWS7Dx06pj5AfGCY66Z1in+JFRvpW/uEzZ7nWuwVLPQ884k19iQ6w7d1/5Qc099RatDSrv4p3WKUl685w3Dmy83kMhDvhX
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;6:E5kj2P1DwucdE+rLSJKu5a0GRNpqdZCZAD1Rrhhrbo2ezL+heObsjdphQQ2GP4HW/1dUFtB1cBp4LVChWwoqKn9Oi2v7CTwIULRWkbORmL4vMCRm67u4v6AjLhhKTD1sc++mxx70ThLq/LADldZuS2bknpPeHEi0YSo4ggKlbPGTTQFNyle3ijIDvrBaa4el2mnEjb+YIY0OF6PIuhe/t4OMPfKRfdD87sZPl941eewao4JpzkrN5ykNVoSe0y3Xgys1qISvDmUh47mpf62Oz+vBnlrHHZgc6sWi0DqHtYdVoXyBrr5+XUJyZ/G132lV5baJCbVySGfj8cYFzb6qDAe3CC76Jfr3/cwGiUhoXwC6JpRFlmrBIupnm7YMBsIjLfQ5Bqd939yGXGezbLb43w9pQlv8ZLh9oAs7Q6qM80MneVUO7cIPOH1cSTDotLSTC+SMR7wG4uyQdjc9ddvKIg==;5:g6zL36m2FWT6FDv2q44x4VQunsF/Hbc608AwnKB7SB5jRXad+NWRSuVKA/avteAzYX/O+9HmjrAb2dxX5mn2FZdU58av9qdYj2EjcwwwUq3YZ37rVgsCLpAp5xN1mQxMIhoHS3KgdEGft70FAMrC1QsT/G9r75gU68hcfYKzpmk=;24:JOIQVhSexa7BG5sGkWyMAUNHnrfcyzUGDrIWE4gmINVP1Kvx4r4751FgIbgKIxf4tl9O78dBw0mt8B4EVyKxbSSRS1WwKTa7jWImY3aIcss=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;7:lHiBHV9eoOLywmZE2UO7FvReH1Ie+uOyNTUuFiGJTmrd3hyXzBIdxFboHKLtqcrGnkCOOhqAMM5XQ5f9cJGIAMW8knslzrRJ3qOeGNS/2PwcKLm5U/P4NL/bVgEmQQnalaD2/ZVaUC7sgwg1b9jXX6ShjQqdUbjJdNRPk3e60NjpngXm83+IQusERBmsiY6QPHrS7NjWPOne8kz9U1grMWUirEZmvWDj7kxMjiHs9cUKMJu4mJb6d9HMpy/xglOA;20:MA4giM8fnffnv7pK/8nYuxThl9TToZKQVyC7YtqHDy2gl77lfqycw2cAgPHXQKZlCvhl2H9s63pZcf2/dX/OPkH5oEp3K3foncL0X9mdGKcUUKVf0bHHpOUuSN3LpaSNEbSalD+tdu4+62EUAmEnLJttSywQSu5998FAK+W0mQE=
X-MS-Office365-Filtering-Correlation-Id: e25673ff-4fa9-4542-ee44-08d5c23c9670
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 12:39:41.3357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25673ff-4fa9-4542-ee44-08d5c23c9670
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4579
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The algorithm used for linux Wound/Wait mutexes, is actually not Wound/Wait
but Wait/Die. See for example

http://www.mathcs.emory.edu/~cheung/Courses/554/Syllabus/8-recv+serial/deadlock-compare.html

Rather than renaming them across the tree to something like Wait/Die mutexes or
Deadlock Avoidance mutexes, this patch set implements also the Wound/Wait
algorithm It shouldn't touch the binary ordinary mutex paths when compiled
with otpimization.
We use Wound/Wait for the modeset locks which in theory may benefit slightly
from Wound/Wait rather than Wait/Die, but Wait/Die is actually superior for
larger number of simultaneous contending transactions so we keep the original
implementation as a choice, and don't touch the algorithm used by the
reservation objects.

Performance- and functional testing has been done using 

git://people.freedesktop.org/~thomash/ww_mutex_test

Using WW_BUILTIN and 4 and 16 competing threads.

Another option is of course to ignore the the naming / algorithm inconsistency.
