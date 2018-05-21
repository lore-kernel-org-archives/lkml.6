Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932096AbeEUV7y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:59:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38552 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754092AbeEUV7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:59:49 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix SSBD not being exposed to guests. (v1)
Date: Mon, 21 May 2018 17:54:48 -0400
Message-Id: <20180521215449.26423-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.13.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8900 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=583
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805210256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Without this patch, when launching QEMU with -cpu +ssbd I ended up
with a warning seeing that the CPU does not support - which in fact it does.

The issue was the X86_FEATURE_ -  the kvm_cpuid_7_0_edx_x86_features
had bit 17 set (X86_FEATURE_SSBD), while the right bit should have been
bit 31 ( X86_FEATURE_SPEC_CTRL_SSBD). That meant the masking:

	entry->edx &= kvm_cpuid_7_0_edx_x86_features;

would nicely clear the SSBD bit.

This fixes:
Fixes: 52817587e706 ("x86/cpufeatures: Disentangle SSBD enumeration")

 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Konrad Rzeszutek Wilk (1):
      KVM: VMX: Expose SSBD properly to guests.
