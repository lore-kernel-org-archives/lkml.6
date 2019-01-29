Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3946214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfA2Jbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:31:53 -0500
Received: from ozlabs.org ([203.11.71.1]:59757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfA2Jbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:31:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ph8k4Qm4z9sDB;
        Tue, 29 Jan 2019 20:31:50 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Juliet Kim <minkim@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [RFC 1/6] powerpc:/drc Define interface to acquire arch-specific drc info
In-Reply-To: <e7030879-59e4-88fd-3785-fdd98b7f0a3b@gmail.com>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com> <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com> <e7030879-59e4-88fd-3785-fdd98b7f0a3b@gmail.com>
Date:   Tue, 29 Jan 2019 20:31:49 +1100
Message-ID: <87a7jjstbu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyrel Datwyler <turtle.in.the.kernel@gmail.com> writes:
> On 12/14/2018 12:50 PM, Michael Bringmann wrote:
>> Define interface to acquire arch-specific drc info to match against
>> hotpluggable devices.  The current implementation exposes several
>> pseries-specific dynamic memory properties in generic kernel code.
>> This patch set provides an interface to pull that code out of the
>> generic kernel.
>> 
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>>  include/linux/topology.h |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index cb0775e..df97f5f 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -44,6 +44,15 @@
>
> As far as I know pseries is the only platform that uses DR connectors, and I
> highly doubt that any other powerpc platform or arch ever will. So, I'm not sure
> that this is really generic enough to belong in topology.h.

Right. This does not belong in include/linux.

> If anything I would
> suggest putting this in an include in arch/powerpc/include/ named something like
> drcinfo.h or pseries-drc.h. That will make it visible to modules like rpaphp
> that want/need to use this functionality.

Yeah that would make more sense.

Using "arch" in the name is wrong, it's pseries specific so
pseries_find_drc_match() would be more appropriate.

>> +int arch_find_drc_match(struct device_node *dn,
>> +			bool (*usercb)(struct device_node *dn,
>> +				u32 drc_index, char *drc_name,
>> +				char *drc_type, u32 drc_power_domain,
>> +				void *data),
>> +			char *opt_drc_type, char *opt_drc_name,
>> +			bool match_drc_index, bool ck_php_type,
>> +			void *data);

This function signature is kind of insane.

You end with calls like:

+	return arch_find_drc_match(dn, rpaphp_add_slot_cb,
+			NULL, NULL, false, true, NULL);

Which is impossible to parse.

I feel like maybe this isn't the right level of abstraction.

cheers
