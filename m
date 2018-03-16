Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvjbxt/NX6BWUy+NLopq8vfeY2oXDIvnAfyNCJBrFV8u4U50J1G+02h8nL2zNqoJwMom33q
ARC-Seal: i=1; a=rsa-sha256; t=1521214982; cv=none;
        d=google.com; s=arc-20160816;
        b=AL4TsiJEN5uMVD5JRwnae0uCEMU+1rtKpvtYd09Q0iyFG5ha22ZwNxbqqQyNvoi0td
         RnK4nStTY5Cbow1KR7jLv4Qa01A9bvGNuslFtmk36boII9Il/bgV7RpmEGDVA/7RB5/j
         ZJ8XpYFX9yGK1GKDudB8QiGajZEdIfCawHqheEsDzpSC0/K9SN1sWhjPXfwtMZgcRYbt
         4+8Ec2sPMosZTT9ebbUZjy5D1Isj4QuIZNxHQ1qzqYNgDXE+q53gPAacqalV6shLUxK7
         hXIyLw94U5c0CwYca8eXfBpGrPGxGI6I5YAFZoUWL2Vjx0Tc7VhrurMiHG7GYUxtyF4t
         Xyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eJozvPFDu77guxFPsifjAFrIvPH8MWFbIsFfKiS9TxA=;
        b=DbehLEyhQOfe41F2bxB5zY/f9KA8YEJb2rQPHcurvlE+LD0pkE5WinOVWsbpKphQt9
         uRfgFRMXNuDDh2/ct5z2Ujm0IsXfcZXS3YwX2gKSxqGbfBUU2m0QFUfs2IV0LYyaYqPf
         hPHKVUld8oeWyoUyWkwxqATJXKBtayAgEvlLAymQkFsqDVjECTVP6G69hU/bH3epR5RB
         bjdX/wo7cZEBndSs1UWFmP+8ulb72lpKf6/ua7A9uyLG08cgGqWzsIbgUs4tDEdqmTZf
         YU6lZvCrqibrxykI1WJGd63XGgJM0K1F8CtmzCq1YDj/Io8Bj4yUM9w3rE/NUxRp9zTF
         iMsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Richter <tmricht@linux.vnet.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 087/128] perf annotate: Fix unnecessary memory allocation for s390x
Date: Fri, 16 Mar 2018 16:23:48 +0100
Message-Id: <20180316152340.917059783@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109256388362279?=
X-GMAIL-MSGID: =?utf-8?q?1595109521575071366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.vnet.ibm.com>


[ Upstream commit 36c263607d36c6a3788c09301d9f5fe35404048a ]

This patch fixes a bug introduced with commit d9f8dfa9baf9 ("perf
annotate s390: Implement jump types for perf annotate").

'perf annotate' displays annotated assembler output by reading output of
command objdump and parsing the disassembled lines. For each shown
mnemonic this function sequence is executed:

  disasm_line__new()
  |
  +--> disasm_line__init_ins()
       |
       +--> ins__find()
            |
            +--> arch->associate_instruction_ops()

The s390x specific function assigned to function pointer
associate_instruction_ops refers to function s390__associate_ins_ops().

This function checks for supported mnemonics and assigns a NULL pointer
to unsupported mnemonics.  However even the NULL pointer is added to the
architecture dependend instruction array.

This leads to an extremely large architecture instruction array
(due to array resize logic in function arch__grow_instructions()).

Depending on the objdump output being parsed the array can end up
with several ten-thousand elements.

This patch checks if a mnemonic is supported and only adds supported
ones into the architecture instruction array. The array does not contain
elements with NULL pointers anymore.

Before the patch (With some debug printf output):

[root@s35lp76 perf]# time ./perf annotate --stdio > /tmp/xxxbb

real	8m49.679s
user	7m13.008s
sys	0m1.649s
[root@s35lp76 perf]# fgrep '__ins__find sorted:1 nr_instructions:'
			/tmp/xxxbb | tail -1
__ins__find sorted:1 nr_instructions:87433 ins:0x341583c0
[root@s35lp76 perf]#

The number of different s390x branch/jump/call/return instructions
entered into the array is 87433.

After the patch (With some printf debug output:)

[root@s35lp76 perf]# time ./perf annotate --stdio > /tmp/xxxaa

real	1m24.553s
user	0m0.587s
sys	0m1.530s
[root@s35lp76 perf]# fgrep '__ins__find sorted:1 nr_instructions:'
			/tmp/xxxaa | tail -1
__ins__find sorted:1 nr_instructions:56 ins:0x3f406570
[root@s35lp76 perf]#

The number of different s390x branch/jump/call/return instructions
entered into the array is 56 which is sensible.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20171124094637.55558-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/arch/s390/annotate/instructions.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -18,7 +18,8 @@ static struct ins_ops *s390__associate_i
 	if (!strcmp(name, "br"))
 		ops = &ret_ops;
 
-	arch__associate_ins_ops(arch, name, ops);
+	if (ops)
+		arch__associate_ins_ops(arch, name, ops);
 	return ops;
 }
 
