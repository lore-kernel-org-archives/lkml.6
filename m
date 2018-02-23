Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225NIbMIigKExBbcu7/6+XeWFEDGMmFRzY9Wi4OLhjasJsLovi8wOBLOnimIcssk8E+YDc40
ARC-Seal: i=1; a=rsa-sha256; t=1519412237; cv=none;
        d=google.com; s=arc-20160816;
        b=UcwqaLfaDktWGwkM6+puh3SwofTTsrnBQfRa4n1ai4Zx81kbIWHEdhTUdDddalfiXS
         E7W7kzLQ9ewirnsDAHmJKIuSdDJLGmvcSLiNM8SGEOxvz9mtu9A1M/UdMblkwvf0dlVd
         d004LwEVEx4M/107ZSmAg+0ieMeHuW4RBtXcejc+FM3Uxq98hk24V/0hG3z4fGyX1p5N
         BddIbZUj9+lrKfBPJBHONLfAw8D029kTQhSSJ+xk3KPxyaFZppCLmG+PwzOZD7UVvJ01
         unYIMzdNDc8cgCQrte2yzIzXH0QLhWMaKD1HlLnMV9gv8pWfW3Mj5e3xF5BLrZEBX8FV
         KZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RJbd7PaQ4joVNTcKtNqf3QcPbPSQQVxDj5LJEFNjKOY=;
        b=oG97YJMDaGBf7u1uJvJChv4VApd/JC0d5Fy0JoSFDoNjOL68VgY7jUKqtlASuD2YtV
         fCLzE+x0bHN7E1t95uPrXSPagKVWzn9iM0zvyTK5v4U6vE4EjacqU8+uVf0Ja53GN30j
         g3gpyujcrrG1itCHO2PwD80MyDJvFg8h2SPHBsqIju4Ahg9JD0XQojgTaewrNE9jVhPu
         a+84cajxzAAsgEn9mj1/6cmG9SGeEnrdJ/ZscD7WG/PbBZOVxcWeqampfvQY7koeFkrf
         4Rq1DQsesoeuPqdLe0elrQ3TDgPLz4ep+HebdIDyuHjr2bvSMYRHgeq1HzXs/UGF5WmI
         fuDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anju T Sudhakar <anju@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 152/159] powerpc/perf/imc: Fix nest-imc cpuhotplug callback failure
Date: Fri, 23 Feb 2018 19:27:40 +0100
Message-Id: <20180223170801.356982256@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219206613374961?=
X-GMAIL-MSGID: =?utf-8?q?1593219206613374961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>


[ Upstream commit ad2b6e01024ef23bddc3ce0bcb115ecd8c520b7e ]

Oops is observed during boot:

  Faulting instruction address: 0xc000000000248340
  cpu 0x0: Vector: 380 (Data Access Out of Range) at [c000000ff66fb850]
      pc: c000000000248340: event_function_call+0x50/0x1f0
      lr: c00000000024878c: perf_remove_from_context+0x3c/0x100
      sp: c000000ff66fbad0
     msr: 9000000000009033
     dar: 7d20e2a6f92d03c0
    pid = 14, comm = cpuhp/0

While registering the cpuhotplug callbacks for nest-imc, if we fail in
the cpuhotplug online path for any random node in a multi node
system (because the opal call to stop nest-imc counters fails for that
node), ppc_nest_imc_cpu_offline() will get invoked for other nodes who
successfully returned from cpuhotplug online path.

This call trace is generated since in the ppc_nest_imc_cpu_offline()
path we are trying to migrate the event context, when nest-imc
counters are not even initialized.

Patch to add a check to ensure that nest-imc is registered before
migrating the event context.

Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/perf/imc-pmu.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -309,6 +309,19 @@ static int ppc_nest_imc_cpu_offline(unsi
 		return 0;
 
 	/*
+	 * Check whether nest_imc is registered. We could end up here if the
+	 * cpuhotplug callback registration fails. i.e, callback invokes the
+	 * offline path for all successfully registered nodes. At this stage,
+	 * nest_imc pmu will not be registered and we should return here.
+	 *
+	 * We return with a zero since this is not an offline failure. And
+	 * cpuhp_setup_state() returns the actual failure reason to the caller,
+	 * which in turn will call the cleanup routine.
+	 */
+	if (!nest_pmus)
+		return 0;
+
+	/*
 	 * Now that this cpu is one of the designated,
 	 * find a next cpu a) which is online and b) in same chip.
 	 */
