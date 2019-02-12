Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A95C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4482B20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549965237;
	bh=EFijitDAnYbGumAIWyNs+KdKOOdzXlmahj3GLOHXWfY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yTSmSx/Fcll7EyQtzbf6EugZVJm0PjUro2EWRDUXaW/I6lUJP4Q8y3FtwxKmSJlyE
	 ahoMkOMPEppiAm49qo5cxjMHnuwPT/RGqCxR19mBUJPQdxiVqUGHrEPxu3Znl1GAU9
	 a/8HYeiZVIVCkenGe4oIaGnUMlpSCKwhY6OYyxcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfBLJxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:53:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33623 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfBLJxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:53:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id a2so1661662edi.0;
        Tue, 12 Feb 2019 01:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFijitDAnYbGumAIWyNs+KdKOOdzXlmahj3GLOHXWfY=;
        b=R3CUk0JkEvVgQlMmu/vGx4TojBHrCuZKz3Fs9UhYW3cNW98MyEUG7dGzMD+BeK2DSt
         SzuDXdCgzsRfQvbXRGKnVLgVbQDFp3EYfRbERtGbQyiP+X8+9XHmDUed6/pr6htoFswX
         bxqKZHSnKyFMznruT4zn6uUdHFK+RGdI4JZB6/1QeWNxgwLXbTZOQ2hdPSJw6ZtHiUeQ
         SAAebjwAgM77UUceLzC2R5lq1kK6Fn4sGp7BrLXaOAATQug2TMFVJco5ybIVJrXfuPBS
         9OTYxVjaS2Ics0O3QvyX6Y935eZE6mAkakUKHOnpr1+Uu0GDzLXZF1V0l6z8ZK1kNEnd
         mBpw==
X-Gm-Message-State: AHQUAuYnLuGB/2s/T3cfAcpjqBgXFS5qLxehj/6X1VN7jPCjQ1TwAF/8
        iVotR0taGNPwS1vd01ZrgUs=
X-Google-Smtp-Source: AHgI3IZuQQu7DIy+YQkt/vIiKLToazp6FM++4dnhmcZqF3E9VfSmrDOChUquc2Ds0W5XPmXFSJDecA==
X-Received: by 2002:a17:906:32c7:: with SMTP id k7mr2066905ejk.180.1549965233523;
        Tue, 12 Feb 2019 01:53:53 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i14sm2876791ejy.25.2019.02.12.01.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:53:52 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/2] x86, numa: always initialize all possible nodes
Date:   Tue, 12 Feb 2019 10:53:41 +0100
Message-Id: <20190212095343.23315-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this has been posted as an RFC previously [1]. There didn't seem to be
any objections so I am reposting this for inclusion. I have added a
debugging patch which prints the zonelist setup for each numa node
for an easier debugging of a broken zonelist setup.

[1] http://lkml.kernel.org/r/20190114082416.30939-1-mhocko@kernel.org


